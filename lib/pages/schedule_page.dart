import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final List<ScheduleItem> schedule = [
      ScheduleItem('Period 1/2', '7:55 AM - 9:19 AM', 'English Literature'),
      ScheduleItem('Period 3/4', '9:24 AM - 10:45 AM', 'Algebra II'),
      ScheduleItem('Activity', '10:50 AM - 11:23 AM', ''),
      ScheduleItem('Period 5/6', '11:28 AM - 12:49 PM', 'Biology'),
      ScheduleItem('Period 7/8', '12:54 PM - 2:15 PM', 'World History'),
    ];

    // Get current date
    String currentDate = _formatDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(currentDate),
      ),
      body: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final item = schedule[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                item.periodName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.timeSlot),
                  if (item.className.isNotEmpty)
                    Text(
                      item.className,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                ],
              ),
              trailing: item.className.isNotEmpty
                  ? const Icon(Icons.arrow_forward_ios)
                  : null,
              onTap: item.className.isNotEmpty
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.className} details coming soon!'),
                        ),
                      );
                    }
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class ScheduleItem {
  final String periodName;
  final String timeSlot;
  final String className;

  ScheduleItem(this.periodName, this.timeSlot, this.className);
}