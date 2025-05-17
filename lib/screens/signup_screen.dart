import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: emailController, label: "Email"),
            CustomTextField(controller: passwordController, label: "Password", obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Signup"),
              onPressed: () {
                AuthService.signup(emailController.text, passwordController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Signup successful")),
                );
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

