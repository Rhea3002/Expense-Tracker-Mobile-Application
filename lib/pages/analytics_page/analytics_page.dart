import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPage();
}

class _AnalyticsPage extends State<AnalyticsPage> {
  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        //automaticallyImplyLeading = false,
        elevation: 10,
        centerTitle: true,
        title: Text('Analytics Page'),
      ),
      body: SfCartesianChart(
        title: ChartTitle(text: 'Your Monthly Expenses'),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          StackedAreaSeries<ExpenseData, String>(
              dataSource: _chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.c1,
              name: 'Grocery',
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          StackedAreaSeries<ExpenseData, String>(
              dataSource: _chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.c2,
              name: 'Medical',
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          StackedAreaSeries<ExpenseData, String>(
              dataSource: _chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.c3,
              name: 'Bills',
              markerSettings: MarkerSettings(
                isVisible: true,
              )),
          StackedAreaSeries<ExpenseData, String>(
            dataSource: _chartData,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.c4,
            name: 'Transport',
            markerSettings: MarkerSettings(
              isVisible: true,
            ),
          ),
          StackedAreaSeries<ExpenseData, String>(
            dataSource: _chartData,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.c5,
            name: 'Shopping',
            markerSettings: MarkerSettings(
              isVisible: true,
            ),
          ),
          StackedAreaSeries<ExpenseData, String>(
            dataSource: _chartData,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.c6,
            name: 'Misceleneous',
            markerSettings: MarkerSettings(
              isVisible: true,
            ),
          ),
          StackedAreaSeries<ExpenseData, String>(
            dataSource: _chartData,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.c7,
            name: 'Food',
            markerSettings: MarkerSettings(
              isVisible: true,
            ),
          ),
          StackedAreaSeries<ExpenseData, String>(
            dataSource: _chartData,
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.c8,
            name: 'Entertainment',
            markerSettings: MarkerSettings(
              isVisible: true,
            ),
          ),
        ],
        primaryXAxis: CategoryAxis(),
      ),
    ));
  } //Build method Ends

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData('1', 55, 40, 45, 48, 12, 25, 15, 11),
      ExpenseData('2', 33, 45, 54, 28, 12, 25, 15, 11),
      ExpenseData('3', 43, 23, 20, 34, 12, 25, 15, 11),
      ExpenseData('4', 32, 54, 23, 54, 12, 87, 15, 11),
      ExpenseData('5', 56, 18, 43, 55, 7, 25, 15, 11),
      ExpenseData('6', 23, 54, 33, 56, 12, 45, 15, 11),
      ExpenseData('7', 23, 54, 33, 56, 12, 25, 21, 21),
      ExpenseData('8', 23, 54, 33, 56, 45, 25, 15, 11),
      ExpenseData('9', 23, 54, 33, 56, 12, 25, 15, 11),
      ExpenseData('10', 23, 54, 33, 56, 12, 25, 15, 11),
      ExpenseData('11', 23, 54, 33, 56, 12, 78, 15, 11),
      ExpenseData('12', 23, 54, 33, 56, 12, 25, 15, 11),
    ];
    return chartData;
  }
}

//
class ExpenseData {
  ExpenseData(this.expenseCategory, this.c1, this.c2, this.c3, this.c4, this.c5,
      this.c6, this.c7, this.c8);
  final String expenseCategory;
  final num c1;
  final num c2;
  final num c3;
  final num c4;
  final num c5;
  final num c6;
  final num c7;
  final num c8;
}
