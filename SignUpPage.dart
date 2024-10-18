/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'dart:convert'; // For handling JSON
import 'package:http/http.dart' as http; // For making HTTP requests
// import 'pages/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false; // State to control password visibility
  bool _isConfirmPasswordVisible = false; // State to control confirm password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // Call the custom sign-up method
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  // Custom sign-up method
  void _signUp(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      // If passwords don't match, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      // Send sign-up request to your backend to get a custom Firebase token
      final response = await http.post(
        Uri.parse('https://your-backend-url.com/signup'), // Replace with your backend URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // If the backend returns a valid token, sign in with Firebase
        final customToken = jsonDecode(response.body)['token'];

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCustomToken(customToken);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign up successful!")),
        );

        Navigator.pushNamed(context, '/home'); // Navigate to home page
      } else {
        // If the server doesn't return 200 OK, throw an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-up failed. Please try again.")),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors during sign-in with custom token
      String message;
      if (e.code == 'invalid-custom-token') {
        message = 'The supplied token is not a Firebase custom auth token.';
      } else if (e.code == 'custom-token-mismatch') {
        message = 'The supplied token is for a different Firebase project.';
      } else {
        message = 'Sign-up failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // Handle other types of errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }
}
,*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'dart:convert'; // For handling JSON
import 'package:http/http.dart' as http; // For making HTTP requests

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false; // State to control password visibility
  bool _isConfirmPasswordVisible = false; // State to control confirm password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context,'/home'); // Call the custom sign-up method
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  // Custom sign-up method
  void _signUp(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      // If passwords don't match, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      // Send sign-up request to your backend to get a custom Firebase token
      final response = await http.post(
        Uri.parse('https://your-backend-url.com/signup'), // Replace with your backend URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // If the backend returns a valid token, sign in with Firebase
        final customToken = jsonDecode(response.body)['token'];

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCustomToken(customToken);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign up successful!")),
        );

        Navigator.pushNamed(context, '/home'); // Navigate to home page
      } else {
        // If the server doesn't return 200 OK, throw an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-up failed. Please try again.")),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors during sign-in with custom token
      String message;
      if (e.code == 'invalid-custom-token') {
        message = 'The supplied token is not a Firebase custom auth token.';
      } else if (e.code == 'custom-token-mismatch') {
        message = 'The supplied token is for a different Firebase project.';
      } else {
        message = 'Sign-up failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // Handle other types of errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }
}
