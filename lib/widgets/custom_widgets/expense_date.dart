import 'package:flutter/material.dart';

class ExpenseDate extends StatelessWidget {
  const ExpenseDate({super.key, required this.expenseDate, required this.buttonPressEvent});

  final Widget expenseDate;
  final VoidCallback buttonPressEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        expenseDate,
        IconButton(onPressed: buttonPressEvent, icon: const Icon(Icons.calendar_month)),
      ],
    );
  }

}