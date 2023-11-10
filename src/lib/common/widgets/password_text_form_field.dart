import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

class PasswordTextFormField extends StatefulWidget {
  final String label;
  final String? errorMessage;
  final void Function(String)? onChanged;

  const PasswordTextFormField({
    Key? key,
    required this.label,
    this.errorMessage,
    this.onChanged,
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
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          icon: const Icon(Icons.lock),
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.grey[770]),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#001f3f"))),
          suffixIcon: _suffixIcon(),
          errorText: widget.errorMessage),
      obscureText: showPassword,
    );
  }

  Widget _suffixIcon() {
    Color? color = Colors.grey[700];
    return IconButton(
      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off,
          color: color),
      onPressed: _togglePasswordVisibility,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
