import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import the flutter_tts package
import 'LevelSelectionPage.dart'; // Import LevelSelectionPage to navigate back to it
import 'package:joyful_journey/pages/questions.dart';

class GamePage extends StatefulWidget {
  final int level;

  const GamePage({super.key, required this.level});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final FlutterTts flutterTts = FlutterTts();
  late Question question; // Hold the question for this level
  late int totalQuestions;

  @override
  void initState() {
    super.initState();
    List<Question> allQuestions = getQuestions(); // Get all questions
    totalQuestions = allQuestions.length;
    if (widget.level <= totalQuestions) {
      question = allQuestions[widget.level - 1]; // Load the question for the selected level
      _speakQuestion(); // Speak the question
    }
  }

  Future<void> _speakQuestion() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(question.questionText);
  }

  void _checkAnswer(String selectedOption) {
    String correctAnswer = question.answer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedOption == correctAnswer ? 'Correct!' : 'Wrong!'),
          content: Text(selectedOption == correctAnswer
              ? 'Well done! Proceed to the next level.'
              : 'The correct answer is $correctAnswer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LevelSelectionPage(),
                  ),
                      (route) => false,
                );
              },
              child: const Text('Back to Level Selection'),
            ),
            if (selectedOption == correctAnswer && widget.level < totalQuestions)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Move to the next level
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(level: widget.level + 1),
                    ),
                  );
                },
                child: const Text('Next Level'),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Level ${widget.level}'),
      ),
      body: Center(
        child: widget.level <= totalQuestions
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question.questionText,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final option = question.options[index];
                  return GestureDetector(
                    onTap: () => _checkAnswer(option['name']),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: option['color'],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        option['name'],
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _speakQuestion,
              child: const Text('Repeat Question'),
            ),
          ],
        )
            : Text(
          'Congratulations! You have completed Level ${widget.level}.',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
