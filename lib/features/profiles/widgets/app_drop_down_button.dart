// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:petsica/core/constants.dart';

import '../../../core/utils/styles.dart';

class PetTypeDropdown extends StatefulWidget {
  const PetTypeDropdown({
    super.key,
    required this.labelText,
  });

  final String labelText;
  @override
  State<PetTypeDropdown> createState() => _PetTypeDropdownState();
}

class _PetTypeDropdownState extends State<PetTypeDropdown> {
  final List<String> petTypes = ['Cat', 'Dog'];
  final List<String> petGender = ['Female', 'Male'];
  final List<String> petAge = ['1 year', '2 years'];
  String selectedPet = 'Cat';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedPet,
          items: petTypes.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedPet = newValue!;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: kInputFieldBackgroundColor,
            labelText: widget.labelText,
            labelStyle: GoogleFonts.comfortaa(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: kInputWordColor,
            ),
            floatingLabelStyle: const TextStyle(
              color: kProducPriceColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: kProducPriceColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: kStorkTextFieldColor,
                width: 1,
              ),
            ),
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
}
