import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final String label;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PasswordTextFormField({
    Key? key,
    required this.label,
    this.errorMessage,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          icon: const Icon(Icons.lock),
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.grey[770]),
          ),
          suffixIcon: _suffixIcon(),
          errorText: widget.errorMessage),
      obscureText: showPassword,
    );
  }

  Widget _suffixIcon() {
    return IconButton(
      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
      onPressed: _togglePasswordVisibility,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
