import 'package:flutter/material.dart';

class ExpenseCancel extends StatelessWidget {
  const ExpenseCancel({super.key, required this.onCancelEvent});

  final void Function() onCancelEvent;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onCancelEvent, child: const Text('Cancel'));
  }
}