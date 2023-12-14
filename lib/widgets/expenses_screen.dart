import 'package:expense_tracker/modal/add_expense.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  Expense? enteredExpenses;
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 20.99,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Cinema',
      amount: 15.59,
      category: Category.leisure,
      date: DateTime.now(),
    ),
  ];

  void _openAddExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(addEnteredExpense: _addExpenseList),
    );
  }

  void _addExpenseList(enteredExpenses) {
    setState(() {
      _registeredExpenses.add(enteredExpenses!);
    });
  }

  void removeExpenseList(enteredExpenses) {
    final listIndex = _registeredExpenses.indexOf(enteredExpenses);
    setState(() {
      _registeredExpenses.remove(enteredExpenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(listIndex, enteredExpenses);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainScreen;

    if (_registeredExpenses.isEmpty) {
      mainScreen = const Center(
        child: Text('No expenses found. Try to add some!'),
      );
    } else {
      mainScreen = ExpenseList(
        expenses: _registeredExpenses,
        onRemoved: removeExpenseList,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Chart(chartExpenses: _registeredExpenses),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: mainScreen,
          )
        ],
      ),
    );
  }
}
