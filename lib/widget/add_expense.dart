

import 'dart:io';

import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.addExpense, {super.key});

  final Function(Expense) addExpense;

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  var _selectedCategory = Category.work;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showCalender() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year);
    var pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog(){
    if( Platform.isIOS){
      showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
                  title: const Text('Invalid Input'),
                  content: const Text('Please Enter valid data'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('OK'))
                  ],
                ));
    }else{
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please Enter valid data'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OK'))
                ],
              ));
    }
  }

  void _submitExpenses() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isinValidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isinValidAmount ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    final expense = Expense(_titleController.text.trim(), enteredAmount,
        _selectedDate!, _selectedCategory);
    widget.addExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight =  MediaQuery.viewInsetsOf(context).bottom;

    return SizedBox(height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,16,16, keyboardHeight + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          prefix: Text("\$"), label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'No Selected Date'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: () => _showCalender(),
                          icon: const Icon(Icons.date_range))
                    ],
                  ))
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (category) {
                        if (category == null) return;
                        setState(() {
                          _selectedCategory = category;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () {
                        _submitExpenses();
                      },
                      child: const Text('Save Expense')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
