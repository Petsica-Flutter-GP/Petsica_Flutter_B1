// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petsica/core/constants.dart';

class WorkingHoursField extends StatefulWidget {
  final String label;
  const WorkingHoursField({
    super.key,
    required this.label,
  });

  @override
  _WorkingHoursFieldState createState() => _WorkingHoursFieldState();
}

class _WorkingHoursFieldState extends State<WorkingHoursField> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }

        if (_startTime != null && _endTime != null) {
          _controller.text =
              "${_formatTime(_startTime!)} to ${_formatTime(_endTime!)}";
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final DateTime now = DateTime.now();
    final DateTime formattedTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(formattedTime); // ➜ تنسيق الوقت مثل 8:00 AM
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: GoogleFonts.comfortaa(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kInputWordColor, // ✅ اللون الافتراضي
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kBurgColor, // ✅ لون الحد عند التركيز
            width: 1,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: kBurgColor, // ✅ تغيير لون كلمة "Username" عند التركيز
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kStorkTextFieldColor, // ✅ لون الحد في الوضع العادي
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.access_time, color: Colors.black54),
          onPressed: () async {
            await _selectTime(context, true); // اختيار وقت البداية
            await _selectTime(context, false); // اختيار وقت النهاية
          },
        ),
      ),
    );
  }
}
