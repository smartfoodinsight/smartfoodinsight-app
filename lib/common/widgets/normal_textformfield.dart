import 'package:flutter/material.dart';

class NormalTextFormField extends StatefulWidget {
  final String label;
  final Icon? icon;

  const NormalTextFormField({
    Key? key,
    required this.label,
    this.icon,
  }) : super(key: key);

  @override
  State<NormalTextFormField> createState() => _NormalTextFormField();
}

class _NormalTextFormField extends State<NormalTextFormField> {
  final textEditingController = TextEditingController();
  bool showClearButton = false;

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
          suffixIcon: _buildSuffixIcon()),
    );
  }

  Widget? _buildSuffixIcon() {
    return showClearButton
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => textEditingController.clear())
        : null;
  }
}
