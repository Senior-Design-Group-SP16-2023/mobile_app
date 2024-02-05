import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RecentActivityWithBarChart extends StatefulWidget {
  @override
  _RecentActivityWithBarChartState createState() => _RecentActivityWithBarChartState();
}

class _RecentActivityWithBarChartState extends State<RecentActivityWithBarChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the Column wraps its content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.bar_chart),
                    SizedBox(width: 8),
                    Text(
                      'Past Workouts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  height: 200, // Specify your custom height
                  child: charts.BarChart(
                    createSampleData(),
                    animate: true,
                    domainAxis: new charts.OrdinalAxisSpec(),
                    primaryMeasureAxis: charts.NumericAxisSpec(
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                        // Adjust the desiredTickCount for more granularity
                        desiredTickCount: 4, // This adds an additional label by increasing the tick count
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static List<charts.Series<WorkoutAccuracy, String>> createSampleData() {
    final bicepCurlAccuracy = [
      WorkoutAccuracy('Mon', 10),
      WorkoutAccuracy('Tue', 35),
      WorkoutAccuracy('Wed', 23),
      WorkoutAccuracy('Thu', 42),
      WorkoutAccuracy('Fri', 69),
    ];

    return [
      charts.Series<WorkoutAccuracy, String>(
        id: 'Bicep Curl',
        domainFn: (WorkoutAccuracy accuracy, _) => accuracy.session,
        measureFn: (WorkoutAccuracy accuracy, _) => accuracy.percentage,
        data: bicepCurlAccuracy,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (WorkoutAccuracy row, _) => '${row.percentage}%',
      ),
    ];
  }
}

class WorkoutAccuracy {
  final String session;
  final int percentage;

  WorkoutAccuracy(this.session, this.percentage);
}
