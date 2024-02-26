import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RecentActivityGraphWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const RecentActivityGraphWidget({super.key, required this.data});

  @override
  State<RecentActivityGraphWidget> createState() =>
      _RecentActivityGraphWidgetState();
}

class _RecentActivityGraphWidgetState extends State<RecentActivityGraphWidget> {
  String dropDownValue = '5';
  var allValues = ['3', '5', '7', 'All']; //This should be changed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          value: dropDownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: allValues.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          },
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        minY: 50, // Set minimum y-value to include 50
                        maxY: 100, // Set maximum y-value to include 100
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval:
                              10, // Increased for reduced frequency
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return Text(value.toInt().toString());
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                TextStyle customStyle = const TextStyle(
                                  fontSize: 12, // Adjusted font size
                                  fontWeight: FontWeight.bold,
                                );
                                // Convert value to int to remove the decimal point
                                return Text(value.toInt().toString(),
                                    style: customStyle);
                              },
                              reservedSize:
                                  40, // Adjusted reserved size for labels
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: createData(),
                            isCurved: false,
                            color: Colors.blue,
                            barWidth: 5,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
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

  List<FlSpot> createData() {
    List<FlSpot> spots = [];
    for (int i = 0; i < widget.data.length; i++) {
      double workoutId = (i + 1).toDouble();
      double accuracy = widget.data[i]['accuracy'].toDouble();
      spots.add(FlSpot(workoutId, accuracy));
    }
    return spots;
  }
}
