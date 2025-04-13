import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({super.key});

  @override
  _SwitchExampleState createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<AppSwitch> {
  bool _isOn = false;

  void _toggleSwitch(bool value) {
    setState(() {
      _isOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isOn,
      onChanged: _toggleSwitch,
      activeTrackColor: kProducPriceColor,
    );
  }
}
