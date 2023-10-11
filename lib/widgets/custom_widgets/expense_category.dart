import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key, required this.categoryValue, required this.expenseItem, required this.onPressedFunction, });

  final Category categoryValue;
  final List<DropdownMenuItem<dynamic>> expenseItem;
  final void Function(dynamic) onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(value: categoryValue, items: expenseItem, onChanged: (dynamic) {
      onPressedFunction;
    });
  }

}