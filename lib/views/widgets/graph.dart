import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class RecentActivityGraphWidget extends StatefulWidget {
  final UserViewModel userViewModel;
  final List<Map<String, dynamic>> data;
  final String userName;

  const RecentActivityGraphWidget(
      {super.key,
      required this.data,
      required this.userViewModel,
      this.userName = ''});

  @override
  State<RecentActivityGraphWidget> createState() =>
      _RecentActivityGraphWidgetState();
}

class _RecentActivityGraphWidgetState extends State<RecentActivityGraphWidget> {
  String dropDownValue = '5';
  var allValues = ['3', '5', '7', 'All']; //This should be changed
  List<Map<String, dynamic>> workoutData = [];

  @override
  void initState() {
    super.initState();
    workoutData = widget.data;
  }

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
                      const Icon(Icons.bar_chart, color: Colors.black),
                      const SizedBox(width: 8),
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
                            updateData(newValue!);
                          },
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        minY: workoutData.isNotEmpty
                            ? ((workoutData.reduce((a, b) =>
                                                a['accuracy'] < b['accuracy']
                                                    ? a
                                                    : b)['accuracy'] as num)
                                            .toDouble() /
                                        10)
                                    .floor() *
                                10
                            : 0,
                        maxY: 100, // Set maximum y-value to include 100
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval:
                              20, // Increased for reduced frequency
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: workoutData.isNotEmpty ? true : false,
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

  Future<void> updateData(String newValue) async {
    int numWorkouts = newValue != "All"
        ? int.parse(newValue)
        : -1; // This might not be the best
    var data = await widget.userViewModel
        .fetchWorkoutData(numWorkouts, widget.userName);
    setState(() {
      dropDownValue = newValue;
      workoutData = data;
    });
  }

  List<FlSpot> createData() {
    List<FlSpot> spots = [];
    for (int i = 0; i < workoutData.length; i++) {
      double workoutId = (i + 1).toDouble();
      double accuracy = workoutData[i]['accuracy'].toDouble();
      spots.add(FlSpot(workoutId, accuracy));
    }
    return spots;
  }
}
