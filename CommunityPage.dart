import 'dart:async'; // Import this to use Timer
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Focus node for the text field
  final List<String> _messages = [];
  final List<bool> _isSentMessages = []; // Track if the messages are sent by the user
  bool _isJoined = false; // Track if the user has joined the chat group

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _isSentMessages.add(true); // Mark message as sent
        _controller.clear();
      });

      // Automatically focus the text field after sending a message
      FocusScope.of(context).requestFocus(_focusNode);

      // Simulate a response from the AI after a delay
      Timer(const Duration(seconds: 1), _receiveReply);
    }
  }

  void _receiveReply() {
    // Generate a response based on the user's message
    String userMessage = _messages.last;
    String aiResponse = _getAIResponse(userMessage); // Get the AI response based on the user's message

    setState(() {
      _messages.add(aiResponse); // Add the AI response to the chat
      _isSentMessages.add(false); // Mark this message as received
    });
  }

  String _getAIResponse(String message) {
    // Basic keyword matching for AI responses
    if (message.toLowerCase().contains("hello") || message.toLowerCase().contains("hi")) {
      return "Hello! How can I assist you today?";
    } else if (message.toLowerCase().contains("What will best for for my child in your app? ")) {
      return "ok if want to enhance your child nature you can use our naturedev video it will surely help and if want to teach his/her count,A to Z ect you can use our learning page";
    } else if (message.toLowerCase().contains("learn")) {
      return "I can help you with learning resources. What topic are you interested in?";
    } else if (message.toLowerCase().contains("games")) {
      return "We have fun games to play! Would you like to know more?";
    } else {
      return "I'm not sure how to respond to that. Can you ask something else?";
    }
  }

  void _joinChat() {
    setState(() {
      _isJoined = true; // Update the state to indicate the user has joined
    });
    // Automatically focus the text field when joining the chat
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isJoined
                ? ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: _isSentMessages[index] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7, // Limit the width of the message
                    ),
                    decoration: BoxDecoration(
                      color: _isSentMessages[index] ? Colors.blue : Colors.grey[300], // Sent messages in blue, received in grey
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _messages[index],
                      style: TextStyle(
                        color: _isSentMessages[index] ? Colors.white : Colors.black, // Text color
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            )
                : const Center(
              child: Text(
                'Join the community to start messaging!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (_isJoined) // Show message input only if joined
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode, // Assign the focus node
                      maxLines: 4, // Limit the text field to 4 lines
                      minLines: 1, // Minimum number of lines displayed
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        _sendMessage(); // Send message on enter
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          if (!_isJoined) // Show the join button only if not joined
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _joinChat,
                child: const Text('Join Community'),
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
