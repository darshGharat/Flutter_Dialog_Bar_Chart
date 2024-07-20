import 'package:expense_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.list, required this.removeDataFromList});

  final List<Expense> list;
  final Function(int index) removeDataFromList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(list[index]),
          onDismissed: (direction) {
            removeDataFromList(index);
          },
          background: Expanded(
            child: Container(color: Theme.of(context).colorScheme.error,
            child: const Text('Delete'),),
          ),
          child: ExpensesItem(itemData: list[index])),
    );
  }
}
