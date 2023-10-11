import 'dart:io';

import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/custom_widgets/expense_cancel.dart';
import 'package:expense_tracker/widgets/custom_widgets/expense_category.dart';
import 'package:expense_tracker/widgets/custom_widgets/expense_date.dart';
import 'package:expense_tracker/widgets/custom_widgets/expense_detail.dart';
import 'package:expense_tracker/widgets/custom_widgets/expense_submit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _expenseController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid expense, amount, date and category is selected.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay')),
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid expense, amount, date and category is selected.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay')),
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_expenseController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense(
        title: _expenseController.text,
        category: _selectedCategory,
        amount: enteredAmount,
        date: _selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _expenseController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      final width = constraint.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600) // NO curly braces
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ExpenseDetail(
                            textController: _expenseController,
                            textLength: 50,
                            textLabel: 'Expense'),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                          child: ExpenseDetail(
                              textController: _amountController,
                              textInputType: TextInputType.number,
                              textLabel: 'Amount',
                              prefix: '\$ ')),
                    ],
                  )
                else
                  ExpenseDetail(
                      textController: _expenseController,
                      textLength: 50,
                      textLabel: 'Expense'),
                if (width >= 600)
                  Row(
                    children: [
                      ExpenseCategory(
                          categoryValue: _selectedCategory,
                          expenseItem: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onPressedFunction: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: ExpenseDate(
                            expenseDate: Text(_selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!)),
                            buttonPressEvent: _presentDatePicker),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                          child: ExpenseDetail(
                              textController: _amountController,
                              textInputType: TextInputType.number,
                              textLabel: 'Amount',
                              prefix: '\$ ')),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ExpenseDate(
                            expenseDate: Text(_selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!)),
                            buttonPressEvent: _presentDatePicker),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ExpenseCancel(onCancelEvent: () {
                        _expenseController.clear();
                        _amountController.clear();
                        Navigator.pop(context);
                      }),
                      ExpenseSubmit(onSubmitEvent: _submitExpenseData),
                    ],
                  )
                else
                  Row(
                    children: [
                      ExpenseCategory(
                          categoryValue: _selectedCategory,
                          expenseItem: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onPressedFunction: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      ExpenseCancel(onCancelEvent: () {
                        _expenseController.clear();
                        _amountController.clear();
                        Navigator.pop(context);
                      }),
                      ExpenseSubmit(onSubmitEvent: _submitExpenseData),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
