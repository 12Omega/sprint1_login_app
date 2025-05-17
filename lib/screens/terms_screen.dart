import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms and Services")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "By using this app, you agree to our Terms and Conditions...",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
