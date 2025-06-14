import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/community/views/home_page.dart';
import 'set_reminder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

const int kBurgColor = 0xff70161E;

class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({super.key});

  @override
  _ReminderListScreenState createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  List<Map<String, dynamic>> reminders = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AudioPlayer audioPlayer = AudioPlayer();
  int notificationId = 0; // Unique ID for each notification

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    // Ensure timezone is initialized here as a safeguard
    tz.initializeTimeZones();
  }

  Future<void> _requestPermissions() async {
    // Request notification permissions
    if (Platform.isAndroid) {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    }

    // Request alarm permissions
    try {
      final alarmStatus = await Permission.scheduleExactAlarm.request();
      if (!alarmStatus.isGranted) {
        if (mounted) {
          _showPermissionDeniedDialog("Alarm");
        }
      }
    } catch (e) {
      print("Failed to request exact alarm permission: $e");
    }

    // Request notification permissions
    try {
      final notificationStatus = await Permission.notification.request();
      if (!notificationStatus.isGranted) {
        if (mounted) {
          _showPermissionDeniedDialog("Notification");
        }
      }
    } catch (e) {
      print("Failed to request notification permission: $e");
    }
  }

  void _showPermissionDeniedDialog(String permissionType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$permissionType Permission Required"),
          content: Text(
              "This app needs $permissionType permission to function properly. Please grant the permission in your device settings."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Open Settings"),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void addReminder(String name, String time, String period, String repeatOption, String soundPath) async {
    try {
      // Parse time
      final timeParts = time.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      // Convert to 24-hour format
      if (period == "PM" && hour != 12) {
        hour += 12;
      } else if (period == "AM" && hour == 12) {
        hour = 0;
      }

      // Calculate next occurrence with timezone safety
      final scheduledTime = _nextInstanceOfTime(hour, minute);

      // Prepare reminder data
      final reminderData = {
        'id': notificationId,
        'name': name,
        'time': "$time $period",
        'isOn': true,
        'repeatOption': repeatOption,
        'soundPath': soundPath,
        'hour': hour,
        'minute': minute,
      };

      // Schedule notification (with fallback if sound fails)
      await _scheduleNotification(reminderData).catchError((e) {
        print("Failed to schedule notification: $e");
        // Continue adding reminder even if notification fails
      });

      // Add to the list regardless of notification success
      setState(() {
        reminders.add(reminderData);
        notificationId++; // Increment for next reminder
      });
    } catch (e) {
      print("Error adding reminder: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error adding reminder: $e")),
        );
      }
    }
  }

  Future<void> _scheduleNotification(Map<String, dynamic> reminderData) async {
    try {
      final id = reminderData['id'];
      final name = reminderData['name'];
      final hour = reminderData['hour'];
      final minute = reminderData['minute'];
      final repeatOption = reminderData['repeatOption'];
      final soundPath = reminderData['soundPath'] ?? 'notification_sound'; // Default sound

      final scheduledTime = _nextInstanceOfTime(hour, minute);

      // Prepare notification details with a safe default sound
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'reminders_channel',
        'Reminders',
        channelDescription: 'Notifications for your reminders',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(soundPath), // Use default if invalid
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      );

      final platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Schedule the notification
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        name,
        "It's time for $name!",
        scheduledTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents:
            repeatOption == "Everyday" ? DateTimeComponents.time : null,
      );

      print("Notification scheduled for $name at $scheduledTime");
    } catch (e) {
      print("Error scheduling notification: $e");
      rethrow;
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    // Ensure timezone is initialized
    if (tz.local == null) {
      tz.initializeTimeZones(); // Reinitialize if not set
    }
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  void deleteReminder(int index) {
    final reminder = reminders[index];
    final id = reminder['id'];
    
    // Cancel the notification
    flutterLocalNotificationsPlugin.cancel(id);
    
    // Remove from the list
    setState(() {
      reminders.removeAt(index);
    });
  }

  void toggleReminder(int index) {
    final reminder = reminders[index];
    final id = reminder['id'];
    final isOn = reminder['isOn'];
    
    setState(() {
      reminders[index]['isOn'] = !isOn;
    });
    
    if (isOn) {
      // Cancel the notification
      flutterLocalNotificationsPlugin.cancel(id);
    } else {
      // Reschedule the notification
      _scheduleNotification(reminders[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      ); // Navigate back to HomePage
          },
        ),
        title: const Text("Reminders",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: reminders.isEmpty
                ? const Center(
                    child: Text("No reminders set",
                        style: TextStyle(fontSize: 18)))
                : ListView.builder(
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reminders[index]['name']!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                reminders[index]['time']!,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Repeat: ${reminders[index]['repeatOption']}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Switch(
                                    value: reminders[index]['isOn'],
                                    activeColor: const Color(kBurgColor),
                                    onChanged: (value) => toggleReminder(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => deleteReminder(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SetReminderScreen(onSave: addReminder),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(kBurgColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Add Reminder",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}