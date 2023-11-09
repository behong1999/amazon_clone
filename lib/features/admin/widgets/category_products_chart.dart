import 'package:amazon_clone/features/admin/models/sale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesList;

  const CategoryProductsChart({super.key, required this.salesList});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        barGroups: salesList.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.earning,
                width: 16,
                color: Colors.blue, // Set your preferred color here.
              ),
            ],
          );
        }).toList(),
        borderData: FlBorderData(
            border: const Border(
          left: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        )),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(axisNameWidget: Text('Earnings')),
          bottomTitles: AxisTitles(axisNameWidget: Text('Categories')),
        )));
  }
}
