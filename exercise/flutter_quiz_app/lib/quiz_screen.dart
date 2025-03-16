import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'quiz_question.dart'; 
import 'score_screen.dart'; 

// quiz screen widget
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

// quiz screen state
class _QuizScreenState extends State<QuizScreen> {
  final int totalTime = 60; // total quiz time in seconds
  List<QuizQuestion> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  Timer? timer;
  int secondsRemaining = 60; // start with 60 seconds
  bool isTimedOut = false;
  Map<int, List<String>> userAnswers = {};

  @override
  void initState() {
    super.initState();
    loadQuestions(); // load questions on start
  }

  // load questions from json
  Future<void> loadQuestions() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/questions.json');
      final List<dynamic> rawQuestions = jsonDecode(jsonString);
      setState(() {
        questions = rawQuestions.map((q) => QuizQuestion.fromJson(q)).toList();
        questions.shuffle(Random()); // shuffle questions
        startTimer(); // start countdown
      });
    } catch (e) {
      debugPrint('error loading questions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('failed to load questions: $e')),
      );
    }
  }

  // start countdown timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          isTimedOut = true;
          timer.cancel();
          showScore(); // show score when time's up
        }
      });
    });
  }

  // submit user answer
  void submitAnswer() {
    if (isTimedOut || currentQuestionIndex >= questions.length) return;

    final question = questions[currentQuestionIndex];
    final userAnswer = userAnswers[currentQuestionIndex] ?? [];
    final correctAnswer = question.answer;

    switch (question.type) {
      case 'true or false':
        bool userBoolAnswer = userAnswer.isNotEmpty && userAnswer[0] == 'true';
        if (userBoolAnswer == correctAnswer) score++;
        break;
      case 'single':
        if (userAnswer.isNotEmpty && userAnswer[0] == correctAnswer) score++;
        break;
      case 'multiple':
        List<String> correctList = List<String>.from(correctAnswer);
        if (userAnswer.length == correctList.length &&
            userAnswer.every((answer) => correctList.contains(answer))) {
          score++;
        }
        break;
    }

    setState(() {
      currentQuestionIndex++;
      if (currentQuestionIndex >= questions.length) {
        timer?.cancel();
        showScore(); // show score when quiz ends
      }
    });
  }

  // go to score screen
  void showScore() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
          score: isTimedOut ? 0 : score,
          totalQuestions: questions.length,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // clean up timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('loading questions...'), // show loading
            ],
          ),
        ),
      );
    }
    
    if (currentQuestionIndex >= questions.length) return Container();

    return _buildQuizScreen(); // build quiz ui
  }

  // build main quiz ui
  Widget _buildQuizScreen() {
    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('quiz app - time: $secondsRemaining s'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 16),
            _buildQuestionText(question),
            const SizedBox(height: 20),
            _buildAnswerOptions(question),
            const SizedBox(height: 24),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  // build progress bar
  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'question ${currentQuestionIndex + 1} of ${questions.length}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (currentQuestionIndex + 1) / questions.length,
          backgroundColor: Colors.grey[300],
        ),
      ],
    );
  }

  // build question text
  Widget _buildQuestionText(QuizQuestion question) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          question.question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // build answer options
  Widget _buildAnswerOptions(QuizQuestion question) {
    switch (question.type) {
      case 'true or false':
        return Column(
          children: [
            _buildAnswerType('true/false judgment'),
            RadioListTile<String>(
              title: const Text('true'),
              value: 'true',
              groupValue: userAnswers[currentQuestionIndex]?.firstOrNull ?? '',
              onChanged: (value) => setState(() {
                userAnswers[currentQuestionIndex] = [value!];
              }),
            ),
            RadioListTile<String>(
              title: const Text('false'),
              value: 'false',
              groupValue: userAnswers[currentQuestionIndex]?.firstOrNull ?? '',
              onChanged: (value) => setState(() {
                userAnswers[currentQuestionIndex] = [value!];
              }),
            ),
          ],
        );
      case 'single':
        return Column(
          children: [
            _buildAnswerType('only one correct choice'),
            ...question.options.map((option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: userAnswers[currentQuestionIndex]?.firstOrNull ?? '',
              onChanged: (value) => setState(() {
                userAnswers[currentQuestionIndex] = [value!];
              }),
            )),
          ],
        );
      case 'multiple':
        return Column(
          children: [
            _buildAnswerType('two or more correct choices'),
            ...question.options.map((option) => CheckboxListTile(
              title: Text(option),
              value: userAnswers[currentQuestionIndex]?.contains(option) ?? false,
              onChanged: (value) => setState(() {
                userAnswers[currentQuestionIndex] ??= [];
                if (value == true) {
                  userAnswers[currentQuestionIndex]!.add(option);
                } else {
                  userAnswers[currentQuestionIndex]!.remove(option);
                }
              }),
            )),
          ],
        );
      default:
        return const Text('unknown question type');
    }
  }

  // build answer type hint
  Widget _buildAnswerType(String typeText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        typeText,
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  // build next button
  Widget _buildNextButton() {
    final isLastQuestion = currentQuestionIndex == questions.length - 1;
    final hasSelectedAnswer = userAnswers[currentQuestionIndex]?.isNotEmpty ?? false;
    
    return ElevatedButton(
      onPressed: hasSelectedAnswer ? submitAnswer : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        isLastQuestion ? 'finish quiz' : 'next question',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}