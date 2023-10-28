import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

class NormalTextFormField extends StatefulWidget {
  final String label;
  final String? initValue;
  final IconData? icon;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;

  const NormalTextFormField({
    super.key,
    required this.label,
    this.icon,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.textInputType,
    this.initValue,
  });

  @override
  State<NormalTextFormField> createState() => _NormalTextFormField();
}

class _NormalTextFormField extends State<NormalTextFormField> {
  final textEditingController = TextEditingController();
  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.initValue ?? '';
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
      onChanged: widget.onChanged,
      validator: widget.validator,
      controller: textEditingController,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
          icon: Icon(widget.icon),
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.grey[770]),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#001f3f"))),
          suffixIcon: _suffixIcon(),
          errorText: widget.errorMessage),
    );
  }

  Widget? _suffixIcon() {
    Color? color = Colors.grey[700];
    return showClearButton
        ? IconButton(
            icon: Icon(Icons.clear, color: color), onPressed: () => _clear())
        : null;
  }

  void _clear() {
    textEditingController.clear();
    if (widget.onChanged != null) widget.onChanged!('');
  }
}
