import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final Icon? icon;
  const CustomTextFormField(
      {super.key, required this.label, this.icon, this.isPassword = false});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final TextEditingController textEditingController = TextEditingController();
  bool showClearButton = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    textEditingController.addListener(() {
      setState(() {
        showClearButton = textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          icon: widget.icon,
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.grey[770]),
          ),
          suffixIcon: _buildSuffixIcon(),
        ),
        obscureText: widget.isPassword && !showPassword);
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
        onPressed: _togglePasswordVisibility,
      );
    }

    return showClearButton
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => textEditingController.clear(),
          )
        : null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
