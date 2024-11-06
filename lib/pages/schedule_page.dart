import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<List<ScheduleItem>> _loadScheduleData() async {
    String jsonString = await rootBundle.loadString('assets/mock_schedule.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => ScheduleItem.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_formatDate(DateTime.now())),
      ),
      body: FutureBuilder<List<ScheduleItem>>(
        future: _loadScheduleData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No schedule data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
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
            );
          }
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

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      json['periodName'],
      json['timeSlot'],
      json['className'],
    );
  }
}