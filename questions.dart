// lib/pages/question.dart

import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<Map<String, dynamic>> options;
  final String answer;

  Question({
    required this.questionText,
    required this.options,
    required this.answer,
  });
}

List<Question> getQuestions() {
  return [
    Question(
      questionText: 'Which of them is red color?',
      options: [
        {'name': 'Red', 'color': Colors.red},
        {'name': 'Blue', 'color': Colors.blue},
        {'name': 'Green', 'color': Colors.green},
        {'name': 'Yellow', 'color': Colors.yellow},
      ],
      answer: 'Red',
    ),
    Question(
      questionText: 'how many apple will there after 2 + 2?',
      options: [
      {'name': '🍎🍎🍎', 'color': Colors.grey},
      {'name': '🍎🍎🍎🍎🍎','color': Colors.grey},
      {'name': '🍎🍎🍎🍎', 'color': Colors.grey},
      {'name': '🍎🍎🍎🍎🍎🍎', 'color': Colors.grey},
      ],
      answer: '🍎🍎🍎🍎',
    ),
    Question(
      questionText: 'Greet your friend with well manner??',
      options: [
        {'name': 'Task Completed', 'color': Colors.grey},
        {'name': 'Not Complete','color': Colors.grey},
        {'name': 'Do later', 'color': Colors.grey},
      ],
      answer: 'Task Completed',
    ),
  ];
}
