import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: emailController, label: "Email"),
            CustomTextField(controller: passwordController, label: "Password", obscureText: true),
            CustomTextField(controller: phoneController, label: "Phone Number"),
            Row(
              children: [
                Checkbox(
                  value: agreed,
                  onChanged: (val) => setState(() => agreed = val ?? false),
                ),
                const Text("I agree to the "),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/terms'),
                  child: const Text(
                    "Terms and Services",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (!agreed) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please agree to terms.")));
                  return;
                }

                final success = AuthService.login(
                  emailController.text,
                  passwordController.text,
                  phoneController.text,
                );

                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login failed")));
                }
              },
              child: const Text("Login"),
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




