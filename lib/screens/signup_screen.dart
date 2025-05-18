import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';
import '../common/my_snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool agreed = false;
  bool isLoading = false;

  String? validatePassword(String password) {
    if (password.length < 6) return 'Password must be at least 6 characters long';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Password must contain an uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(password)) return 'Password must contain a lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Password must contain a digit';
    if (!RegExp(r'[!@#\$&*~%^(),.?":{}|<>]').hasMatch(password)) return 'Password must contain a special character';
    return null;
  }

  Future<void> handleSignup() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phone = phoneController.text.trim();

    if (!agreed) {
      showCustomSnackBar(context, "Please agree to the Terms and Services.");
      return;
    }

    final passwordError = validatePassword(password);
    if (passwordError != null) {
      showCustomSnackBar(context, passwordError);
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800)); // simulate auth delay

    AuthService.signup(email, password, phone);

    if (!mounted) return;
    setState(() => isLoading = false);

    showCustomSnackBar(context, "Signup successful", color: Colors.green);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Sign Up")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: ListView(
              children: [
                const Text(
                  "Create Account 📝",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: passwordController,
                  label: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: phoneController,
                  label: "Phone Number",
                  inputType: TextInputType.phone,
                ),
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
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: handleSignup,
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  child: const Text("Sign Up"),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      ],
    );
  }
}







