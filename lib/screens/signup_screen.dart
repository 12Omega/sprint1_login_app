import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
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

                AuthService.signup(
                  emailController.text,
                  passwordController.text,
                  phoneController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Signup successful")),
                );
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Signup"),
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


