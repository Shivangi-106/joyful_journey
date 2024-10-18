import 'package:flutter/material.dart';
import 'GamePage.dart'; // Import the GamePage to navigate to it

class LevelSelectionPage extends StatelessWidget {
  final int totalLevels = 10; // Set the total number of levels
  final String backgroundImage = 'lib/assets/level_page_background.jpg';

  const LevelSelectionPage({super.key}); // Path to your background image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Level"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Add the background image
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          // Overlay the grid of levels
          GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // Set to 5 columns
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: totalLevels,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to GamePage with the selected level
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(level: index + 1), // Pass the selected level
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.withOpacity(0.8), // Slight transparency
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Level ${index + 1}",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
