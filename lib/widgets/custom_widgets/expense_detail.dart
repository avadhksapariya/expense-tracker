import 'package:flutter/material.dart';

class ExpenseDetail extends StatelessWidget {
  const ExpenseDetail({super.key, required this.textController, required this.textLabel, this.textLength, this.textInputType, this.prefix});

  final TextEditingController textController;
  final String textLabel;
  final int? textLength;
  final TextInputType? textInputType;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLength: textLength,
      keyboardType: textInputType,
      decoration: InputDecoration(
        label: Text(textLabel),
        prefixText: prefix,
      ),
    );
  }

}