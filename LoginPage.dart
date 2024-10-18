import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false; // State to control password visibility
  bool _isLoading = false; // State to manage loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
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
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
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
            _isLoading
                ? const CircularProgressIndicator() // Show loading spinner when signing in
                : ElevatedButton(
              onPressed: () {
                // Call the validation and login method
                _validateAndLogin(context);
              },
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/SignUpPage.dart'); // Navigate to the SignUpPage
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to validate email and password before login
  void _validateAndLogin(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Check if email or password is empty
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email.')),
      );
      return; // Exit the function if email is empty
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password.')),
      );
      return; // Exit the function if password is empty
    }

    // If both fields are filled, proceed to login
    _login(context);
  }

  // Method to handle user login with Firebase
  void _login(BuildContext context) async {
    setState(() {
      _isLoading = true; // Show loading indicator when login starts
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Attempt to sign in the user with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // If successful, navigate to the home page
      print('Login successful: $userCredential');
      Navigator.pushNamed(context, '/home'); // Navigate to home page
    } on FirebaseAuthException catch (e) {
      print('Error: $e'); // Print error for debugging

      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password provided.';
      } else {
        message = 'Login failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // Catch any other errors that might occur
      print('An unexpected error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator after login attempt
      });
    }
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
