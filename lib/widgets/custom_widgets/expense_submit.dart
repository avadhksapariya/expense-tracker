import 'package:flutter/material.dart';

class ExpenseSubmit extends StatelessWidget {
  const ExpenseSubmit({super.key, required this.onSubmitEvent});

  final VoidCallback onSubmitEvent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onSubmitEvent, child: const Text('Save Expense'));
  }

}