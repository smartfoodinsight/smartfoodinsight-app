import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final String label;

  const PasswordTextFormField({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: const Icon(Icons.lock),
        label: Text(
          widget.label,
          style: TextStyle(color: Colors.grey[770]),
        ),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      obscureText: showPassword,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
