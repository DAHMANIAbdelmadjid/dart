import 'package:flutter/material.dart';
import 'package:tabibi_2/secrren/dar/payment .dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateAndTime extends StatelessWidget {
  const SelectDateAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date And Time'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: DateTime.now().isBefore(DateTime.utc(2023, 12, 31)) &&
                      DateTime.now().isAfter(DateTime.utc(2023, 1, 1))
                  ? DateTime.now()
                  : DateTime.utc(2023, 1, 1),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(formatButtonVisible: false),
            ),
            SizedBox(height: 20),
            Text('Available Time Slot',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('10.00 AM')),
                ElevatedButton(onPressed: () {}, child: Text('11.00 AM')),
                ElevatedButton(onPressed: () {}, child: Text('12.00 PM')),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Payment()),
                  );
                },
                child: Text('Set Appointment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
