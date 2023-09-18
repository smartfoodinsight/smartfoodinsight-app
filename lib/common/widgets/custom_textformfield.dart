import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final Icon? icon;
  const CustomTextFormField({super.key, required this.label, this.icon});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final textEditingController = TextEditingController();
  bool showClearButton = false;
  bool isPassword = false;

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
            suffixIcon: showClearButton
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => textEditingController.clear())
                : null),
        obscureText: isPassword // Manejo de entrada del usuario
        );
  }
}
