import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/community/views/home_page.dart';
import 'set_reminder.dart';

const int kBurgColor = 0xff70161E;

class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({super.key});

  @override
  _ReminderListScreenState createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  List<Map<String, dynamic>> reminders = [];
  int notificationId = 0; // Used for unique IDs, no longer for notifications

  void addReminder(String name, String time, String period, String repeatOption, String soundPath) {
    try {
      // Parse time for storage
      final timeParts = time.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      // Prepare reminder data
      final reminderData = {
        'id': notificationId,
        'name': name,
        'time': "$time $period",
        'isOn': true,
        'repeatOption': repeatOption,
        'hour': hour,
        'minute': minute,
      };

      // Add to the list
      setState(() {
        reminders.add(reminderData);
        notificationId++; // Increment for next reminder
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error adding reminder: $e")),
        );
      }
    }
  }

  void deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
  }

  void toggleReminder(int index) {
    setState(() {
      reminders[index]['isOn'] = !reminders[index]['isOn'];
    });
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
            );
          },
        ),
        title: const Text(
          "Reminders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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