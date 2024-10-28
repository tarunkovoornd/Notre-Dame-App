import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notre Dame High School'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Notre Dame High School!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Notre Dame High School is a prestigious Catholic institution dedicated to academic excellence, spiritual growth, and character development. Our rigorous curriculum and supportive community prepare students for success in college and beyond.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quick Access:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildButton(context, 'Grades', Icons.grade),
            const SizedBox(height: 12),
            _buildButton(context, 'Schedule', Icons.calendar_today),
            const SizedBox(height: 12),
            _buildButton(context, 'Resources', Icons.library_books),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement navigation to respective pages
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label page not implemented yet')),
          );
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}