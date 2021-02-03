import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("KPI visualization"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Column(
              children: [
                SfCartesianChart(
                  title: ChartTitle(text: "Ventes par an"),
                  legend: Legend(isVisible: true),
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData('Jan', 35),
                          SalesData('Feb', 28),
                          SalesData('Mar', 34),
                          SalesData('Apr', 32),
                          SalesData('May', 40),
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SfCircularChart(
                  legend: Legend(isVisible: true),
                  title: ChartTitle(text: "Ventes du personnel"),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        animationDuration: 3)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SfFunnelChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
