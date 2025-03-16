import 'package:flutter/material.dart';

// score screen widget
class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions) * 100;
    String feedback;
    Color feedbackColor;

    // set feedback based on score
    if (percentage >= 80) {
      feedback = 'excellent!';
      feedbackColor = Colors.green;
    } else if (percentage >= 60) {
      feedback = 'good job!';
      feedbackColor = Colors.blue;
    } else if (percentage >= 40) {
      feedback = 'keep practicing!';
      feedbackColor = Colors.orange;
    } else {
      feedback = 'try again!';
      feedbackColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('quiz result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'quiz completed!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'your score: $score / $totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              feedback,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: feedbackColor,
              ),
            ),
            // no button here anymore
          ],
        ),
      ),
    );
  }
}