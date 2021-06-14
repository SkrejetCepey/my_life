import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StatisticPage extends StatelessWidget {

  final CalendarController calendarController = CalendarController();
  final DateTime actualDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
              children: [
                Center(
                  child: Text("STATISTICS",textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.restore_from_trash_sharp))
              ],
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: TableCalendar(
                locale: 'ru_RU',
                calendarController: calendarController,
                headerVisible: false,
                builders: CalendarBuilders(
                  todayDayBuilder: (context, date, events) {
                    return Container(
                      child: Center(child: Text('${date.day}',
                          style: TextStyle(
                              color: (date.weekday == 6 || date.weekday == 7) ? Colors.red : Colors.black
                          )),),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xffd5f111),
                              width: 2
                          ),
                          shape: BoxShape.circle
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                    );
                  },
                  selectedDayBuilder: (context, date, events) {
                    return Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: Text('${date.day}',
                              style: TextStyle(
                                  color: (date.weekday == 6 || date.weekday == 7) ? Colors.red : Colors.black
                              ),
                            ),
                          ),
                          Container(
                            height: 4.0,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle
                            ),
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                calendarStyle: CalendarStyle(
                    selectedColor: Color(0xffb4baba)
                ),
                initialSelectedDay: actualDate,
                startingDayOfWeek: StartingDayOfWeek.monday,
                initialCalendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                ),
                availableCalendarFormats: {CalendarFormat.month : 'Week'},
              ),
            ),
          ),
        ],
      )
    );
  }
}
