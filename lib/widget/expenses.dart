import 'package:expense_tracker/widget/add_expense.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenseList = [
    Expense("Flutter course", 599.00, DateTime.now(), Category.work),
    Expense("Grocery", 1000.00, DateTime.now(), Category.food),
    Expense("Moview", 299.00, DateTime.now(), Category.leisure),
    Expense("Picnic", 5000.00, DateTime.now(), Category.travel)
  ];

  void _performAddClick() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddExpense(_addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenseList.add(expense);
    });
  }

  void _removeDataFromList(int index) {
    if (_expenseList.isEmpty) {
      return;
    }
    var expense = _expenseList[index];
    setState(() {
      _expenseList.removeAt(index);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('expense removed successfully'),
      action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              _expenseList.insert(index, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    Widget mainContent = const Center(
      child: Text('No records Found'),
    );

    if (_expenseList.isNotEmpty) {
      mainContent = ExpensesList(
        list: _expenseList,
        removeDataFromList: _removeDataFromList,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expense Tracker",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _performAddClick();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: width < height
            ? Column(
                children: [
                  Chart(expenses: _expenseList),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _expenseList)),
                  Expanded(child: mainContent)
                ],
              ));
  }
}
