import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class ShowChartSales extends StatefulWidget {
  @override
  _ShowChartSalesState createState() => _ShowChartSalesState();
}

class _ShowChartSalesState extends State<ShowChartSales> {
  ChartData chartData = ChartData();
  LineChartOptions lineChartOption = LineChartOptions();
  LabelLayoutStrategy labelLayoutStrategy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defineData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: LineChart(
              painter: LineChartPainter(),
              container: LineChartContainer(
                  chartData: chartData,
                  chartOptions: lineChartOption,
                  xContainerLabelLayoutStrategy: labelLayoutStrategy),
            ),
          ),
        ],
      ),
    );
  }

  void defineData() {
    chartData.xLabels = ['Product1', 'Product2', 'Product3', 'Product4'];
    chartData.dataRows = [
      [40.0, 30.0, 10.0, 20.0]
    ];

    chartData.dataRowsLegends = ['Test1', 'Test2', 'Test3', 'Test4'];

    chartData.dataRowsColors = [Colors.red];

    chartData.yLabels = ['one', 'two', 'threee'];

    // lineChartOption.useUserProvidedYLabels = true;

    labelLayoutStrategy =
        DefaultIterativeLabelLayoutStrategy(options: lineChartOption);
  }
}
