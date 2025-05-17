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

  String? validatePassword(String password) {
    if (password.length < 6) {
      return 'Password error: must be at least 6 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password error: must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password error: must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password error: must contain at least one digit (0-9)';
    }
    if (!RegExp(r'[!@#\$&*~%^(),.?":{}|<>]').hasMatch(password)) {
      return 'Password error: must contain at least one special character';
    }
    return null;
  }

  void handleSignup() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final phone = phoneController.text.trim();

    if (!agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please agree to the Terms and Services."),
          duration: Duration(seconds: 8),
        ),
      );
      return;
    }

    final passwordError = validatePassword(password);
    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(passwordError),
          duration: const Duration(seconds: 8),
        ),
      );
      return;
    }

    AuthService.signup(email, password, phone);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Signup successful"),
        duration: Duration(seconds: 8),
      ),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

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
            const SizedBox(height: 12),
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
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: handleSignup,
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





