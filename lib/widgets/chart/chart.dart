import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.chartExpenses});

  final List<Expense> chartExpenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategoty(chartExpenses, Category.food),
      ExpenseBucket.forCategoty(chartExpenses, Category.leisure),
      ExpenseBucket.forCategoty(chartExpenses, Category.travel),
      ExpenseBucket.forCategoty(chartExpenses, Category.work),
    ];
  }

  double get maxTotalExpenses {
    double maxExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpense > maxExpense) {
        maxExpense = bucket.totalExpense;
      }
    }
    return maxExpense;
  }

  @override
  Widget build(BuildContext context) {
    final maxTotalExpense = maxTotalExpenses;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      height: 180,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Theme.of(context).cardTheme.margin!.vertical),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).colorScheme.primary.withOpacity(0.0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          )),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpense == 0
                        ? 0
                        : (bucket.totalExpense / maxTotalExpense),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Icon(
                      categoryIcons[bucket.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
