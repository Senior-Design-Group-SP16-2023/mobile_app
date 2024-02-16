import 'package:flutter/material.dart';
import 'dart:ui'; // Import this for ImageFilter.
import 'package:charts_flutter/flutter.dart' as charts;

class RecentActivityWithBarChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const RecentActivityWithBarChart({super.key, required this.data});

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.bar_chart, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Past Workouts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 200,
                    child: charts.BarChart(
                      createData(),
                      animate: true,
                      domainAxis: new charts.OrdinalAxisSpec(),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          // Change the line color to dark grey
                          lineStyle: charts.LineStyleSpec(
                            color: charts.MaterialPalette.gray.shadeDefault,
                          ),
                          // Change the label color to dark grey
                          labelStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.gray.shadeDefault,
                          ),
                        ),
                        tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<charts.Series<BarGraphData, String>> createData() {
    List<BarGraphData> myDataList = widget.data.map((map) => BarGraphData(map['dayOfWeek'], map['maxAccuracy'])).toList();

    return [
      charts.Series<BarGraphData, String>(
        id: 'Bicep Curl',
        domainFn: (BarGraphData data, _) => data.dayOfWeek,
        measureFn: (BarGraphData data, _) => data.maxAccuracy,
        data: myDataList,
      ),
    ];
  }

}

class BarGraphData {
  final String dayOfWeek; // For x-axis
  final dynamic maxAccuracy; // For y-axis

  BarGraphData(this.dayOfWeek, this.maxAccuracy);
}
