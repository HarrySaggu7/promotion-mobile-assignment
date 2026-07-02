import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  final String label;

  final bool obscureText;

  final TextEditingController controller;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,

      obscureText: obscureText,

      validator: (value) {

        if (value == null || value.isEmpty) {
          return '$label is required';
        }

        return null;
      },

      decoration: InputDecoration(

        labelText: label,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(12),

        ),

      ),

    );
  }
}