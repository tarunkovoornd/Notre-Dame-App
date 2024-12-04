import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  late Future<Map<String, dynamic>> _gradesFuture;
  String _selectedTerm = 'Fall Semester';
  bool _showGrades = false;
  String _selectedPeriod = '1st marking period';

  @override
  void initState() {
    super.initState();
    _gradesFuture = _loadGradesData();
  }

  Future<Map<String, dynamic>> _loadGradesData() async {
    String jsonString = await rootBundle.loadString('assets/mock_grades.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Courses',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTermButtons(),
              const SizedBox(height: 16),
              _buildGradeVisibilityButtons(),
              if (_showGrades) ...[
                const SizedBox(height: 16),
                _buildMarkingPeriodButtons(),
                const SizedBox(height: 16),
                _buildGradesList(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermButtons() {
    return Row(
      children: [
        const Text('Term:', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        _buildTermButton('Fall Semester'),
        const SizedBox(width: 8),
        _buildTermButton('Spring Semester'),
      ],
    );
  }

  Widget _buildTermButton(String term) {
    return ElevatedButton(
      onPressed: () => setState(() => _selectedTerm = term),
      child: Text(term),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTerm == term ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget _buildGradeVisibilityButtons() {
    return Row(
      children: [
        const Text('Grades:', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        _buildVisibilityButton('Show', true),
        const SizedBox(width: 8),
        _buildVisibilityButton('Hide', false),
      ],
    );
  }

  Widget _buildVisibilityButton(String label, bool visibility) {
    return ElevatedButton(
      onPressed: () => setState(() => _showGrades = visibility),
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _showGrades == visibility ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget _buildMarkingPeriodButtons() {
    return Row(
      children: [
        _buildMarkingPeriodButton('1st marking period'),
        const SizedBox(width: 8),
        _buildMarkingPeriodButton('2nd marking period'),
      ],
    );
  }

  Widget _buildMarkingPeriodButton(String period) {
    return ElevatedButton(
      onPressed: () => setState(() => _selectedPeriod = period),
      child: Text(period),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedPeriod == period ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget _buildGradesList() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _gradesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No grades data available'));
        } else {
          final grades = snapshot.data![_selectedTerm][_selectedPeriod] as List<dynamic>;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grades.length,
            itemBuilder: (context, index) {
              final course = grades[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          course['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${course['grade']}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () => _showAssignments(context, course),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: const Text('See details'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showAssignments(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${course['name']} Assignments'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: (course['assignments'] as List<dynamic>).map((assignment) {
                return ListTile(
                  title: Text(assignment['name']),
                  subtitle: Text('Grade: ${assignment['grade']}'),
                  trailing: Text('Weight: ${(assignment['weight'] * 100).toStringAsFixed(0)}%'),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}