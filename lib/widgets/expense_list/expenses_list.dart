import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoved,
  });

  final List<Expense> expenses;
  final void Function(Expense) onRemoved;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: isDarkMode ? Theme.of(context).colorScheme.onErrorContainer
          : Theme.of(context).colorScheme.errorContainer.withOpacity(0.7),
          margin: Theme.of(context).cardTheme.margin,
        ),
        onDismissed: (direction) => {
          onRemoved(
            expenses[index],
          ),
        },
        key: ValueKey(
          expenses[index],
        ),
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
