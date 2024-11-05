import 'package:flutter/material.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  String _selectedTerm = 'Fall Semester';
  bool _showGrades = false;
  String _selectedPeriod = '1st marking period';

  // Mock data for courses and grades
  final Map<String, Map<String, List<Course>>> _courseData = {
    'Fall Semester': {
      '1st marking period': [
        Course('English Literature', 92),
        Course('Algebra II', 88),
        Course('Biology', 95),
        Course('World History', 91),
      ],
      '2nd marking period': [
        Course('English Literature', 94),
        Course('Algebra II', 90),
        Course('Biology', 93),
        Course('World History', 89),
      ],
    },
    'Spring Semester': {
      '1st marking period': [
        Course('American Literature', 90),
        Course('Pre-Calculus', 87),
        Course('Chemistry', 92),
        Course('Economics', 94),
      ],
      '2nd marking period': [
        Course('American Literature', 93),
        Course('Pre-Calculus', 89),
        Course('Chemistry', 91),
        Course('Economics', 96),
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Courses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Term:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedTerm = 'Fall Semester'),
                  child: const Text('Fall Semester'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTerm == 'Fall Semester' ? Colors.blue : Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedTerm = 'Spring Semester'),
                  child: const Text('Spring Semester'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTerm == 'Spring Semester' ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Grades:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _showGrades = true),
                  child: const Text('Show'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showGrades ? Colors.blue : Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _showGrades = false),
                  child: const Text('Hide'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_showGrades ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
            if (_showGrades) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _selectedPeriod = '1st marking period'),
                    child: const Text('1st marking period'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPeriod == '1st marking period' ? Colors.blue : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => setState(() => _selectedPeriod = '2nd marking period'),
                    child: const Text('2nd marking period'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPeriod == '2nd marking period' ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _courseData[_selectedTerm]![_selectedPeriod]!.length,
                  itemBuilder: (context, index) {
                    final course = _courseData[_selectedTerm]![_selectedPeriod]![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Grade: ${course.grade}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Implement grade details view
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Grade details not implemented yet')),
                                );
                              },
                              child: const Text('See grade details'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final int grade;

  Course(this.name, this.grade);
}