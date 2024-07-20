import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.itemData});

  final Expense itemData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
        child: Column(
          children: [
            Text(
              itemData.title,
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisSize: MainAxisSize.max,
            children: [
              Text('\$ ${itemData.amount}'),
              const Spacer(),
              Row(children:[Icon(categoryIcon[itemData.category]), Text(" ${itemData.formattedDate}")])
            ],)
          ],
        ),
      ),
    );
  }
}
