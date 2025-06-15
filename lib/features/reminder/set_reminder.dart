import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int kBurgColor = 0xff70161E;

class SetReminderScreen extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;

  const SetReminderScreen({super.key, required this.onSave});

  @override
  _SetReminderScreenState createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  int selectedHour = 6;
  int selectedMinute = 30;
  String selectedPeriod = "AM";
  String reminderName = "";
  String repeatOption = "Once"; // Default value for repeat option
  final TextEditingController nameController = TextEditingController();

  String _formatTimeValue(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Set Reminder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPicker(1, 12, selectedHour, (value) {
                    setState(() {
                      selectedHour = value;
                    });
                  }),
                  const Text(":",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  _buildPicker(0, 59, selectedMinute, (value) {
                    setState(() {
                      selectedMinute = value;
                    });
                  }),
                  const SizedBox(width: 10),
                  _buildAmPmPicker(),
                ],
              ),
              const SizedBox(height: 40),
              TextField(
                controller: nameController,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Reminder name",
                  labelText: "Name",
                ),
                onChanged: (val) => reminderName = val,
              ),
              const SizedBox(height: 40),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Repeat",
                ),
                value: repeatOption,
                items: ["Once", "Everyday"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 20)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    repeatOption = newValue!;
                  });
                },
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (reminderName.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a reminder name"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    widget.onSave(
                      reminderName,
                      "${_formatTimeValue(selectedHour)}:${_formatTimeValue(selectedMinute)}",
                      selectedPeriod,
                      repeatOption,
                      '', // Empty soundPath as it's no longer used
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(kBurgColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Set Reminder",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPicker(
      int min, int max, int selectedValue, Function(int) onChanged) {
    return SizedBox(
      height: 180,
      width: 80,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: selectedValue - min),
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          onChanged(index + min);
        },
        children: List.generate(
            max - min + 1,
            (index) => Text("${_formatTimeValue(index + min)}",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
      ),
    );
  }

  Widget _buildAmPmPicker() {
    return SizedBox(
      height: 180,
      width: 80,
      child: CupertinoPicker(
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedPeriod = index == 0 ? "AM" : "PM";
          });
        },
        children: const [
          Text("AM",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text("PM",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}