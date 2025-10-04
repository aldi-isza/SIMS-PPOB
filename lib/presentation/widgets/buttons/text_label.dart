import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String label;
  final bool required;
  final double fontSize;
  final Color color;

  const TextLabel({
    super.key,
    required this.label,
    this.required = false,
    this.fontSize = 14,
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        if (required)
          const Text(
            " *",
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
