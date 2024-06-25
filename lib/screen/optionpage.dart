import 'package:flutter/material.dart';
class OptionPage extends StatelessWidget {
  final String option;
  final String selectedOption; // Add the selected option state
  final Function(String) onSelected; // Add the callback

  const OptionPage({
    super.key,
    required this.option,
    required this.onSelected,
    required this.selectedOption, // Modify constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onSelected(option), // Call the callback when tapped
          child: Container(
            height: 48,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 3, color: const Color(0xff40E0D0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      option,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Radio(
                      value: option,
                      groupValue: selectedOption, // Set the groupValue to selectedOption
                      onChanged: (val) => onSelected(option), // Call the callback on radio button change
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}



