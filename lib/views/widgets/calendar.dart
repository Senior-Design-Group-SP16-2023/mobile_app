import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/workoutdetails_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class CalendarWidget extends StatefulWidget {
  final UserViewModel userViewModel;
  final List<DateTime> workoutData;
  final String userName;

  const CalendarWidget({
    super.key,
    required this.userViewModel,
    required this.workoutData,
    this.userName = '',
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<DateTime> workoutDays = [];
  DateTime _focusedDay = DateTime.now();

  bool isWorkoutDay(DateTime day) {
    return workoutDays.any((workoutDay) =>
    day.year == workoutDay.year &&
        day.month == workoutDay.month &&
        day.day == workoutDay.day);
  }

  @override
  void initState() {
    super.initState();
    workoutDays = widget.workoutData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Calendar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.black),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.black),
                  defaultTextStyle: TextStyle(color: Colors.black),
                ),
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                  updateCalendar(focusedDay);
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (isWorkoutDay(day)) {
                      return Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              day.day.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (day == DateTime.now()) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  if (isWorkoutDay(selectedDay)) {
                    DateTime latestTs = DateTime(selectedDay.year, selectedDay.month, selectedDay.day).add(const Duration(days: 1));
                    widget.userViewModel.fetchWorkoutsInDay(selectedDay, latestTs, widget.userName).then((items) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return WorkoutDetailsView(selectedDay: selectedDay, workouts: items);
                        }),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Selected day is not a workout day')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateCalendar(DateTime earliestTs) async {
    int year = earliestTs.year;
    int month = earliestTs.month;
    if (month == 12) {
      year += 1;
      month = 1;
    } else {
      month += 1;
    }
    DateTime firstDayOfNextMonth = DateTime(year, month, 1, 0, 0, 0);
    var data = await widget.userViewModel.fetchWorkoutsInMonth(earliestTs, firstDayOfNextMonth, widget.userName);
    setState(() {
      workoutDays = data;
    });
  }
}
