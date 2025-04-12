import 'package:flutter/material.dart';

class CustomTextFieldPass extends StatefulWidget {
  final TextEditingController? controller;
  final String text;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFieldPass({
    super.key,
    this.controller,
    required this.text,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextFieldPass> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldPass> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      obscureText: _obscureText,
      obscuringCharacter: '●',
      style: TextStyle(color: Colors.black),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.text,
        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
