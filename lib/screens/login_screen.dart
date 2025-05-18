import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';
import '../common/my_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool agreed = false;
  bool isLoading = false;

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phone = phoneController.text.trim();

    if (!agreed) {
      showCustomSnackBar(context, "Please agree to the Terms and Services.");
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    final success = AuthService.login(email, password, phone);

    if (!mounted) return;
    setState(() => isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showCustomSnackBar(context, "Login failed. Please check your credentials.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Login")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: ListView(
              children: [
                const Text(
                  "Welcome Back 👋",
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
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text("Don't have an account? Sign up"),
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







