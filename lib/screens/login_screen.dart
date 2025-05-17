import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: emailController, label: "Email"),
            CustomTextField(controller: passwordController, label: "Password", obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () {
                final success = AuthService.login(emailController.text, passwordController.text);
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login failed")),
                  );
                }
              },
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}

