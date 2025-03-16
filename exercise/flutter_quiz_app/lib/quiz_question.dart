// quiz question model
class QuizQuestion {
  final String question;
  final String type;
  final List<String> options;
  final dynamic answer;

  // constructor
  QuizQuestion({
    required this.question,
    required this.type,
    required this.options,
    required this.answer,
  });

  // create from json
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'] as String,
      type: json['type'] as String,
      options: json['options'] != null 
          ? List<String>.from(json['options']) 
          : <String>[],
      answer: json['answer'],
    );
  }
}