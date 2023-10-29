import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

class DateTextFormField extends StatefulWidget {
  final String label;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const DateTextFormField({
    super.key,
    required this.label,
    this.errorMessage,
    this.validator,
    this.onChanged,
  });

  @override
  State<DateTextFormField> createState() => _DateTextFormField();
}

class _DateTextFormField extends State<DateTextFormField> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        final dateTime = await _getDate(context);
        textEditingController.text = dateTime;
        if (widget.onChanged != null) widget.onChanged!(dateTime);
      },
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: textEditingController,
      readOnly: true,
      decoration: InputDecoration(
          icon: const Icon(Icons.date_range),
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.grey[770]),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#001f3f"))),
          errorText: widget.errorMessage),
    );
  }

  Future<String> _getDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      return formattedDate;
    }

    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}
