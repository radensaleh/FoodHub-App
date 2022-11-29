import 'package:flutter/material.dart';
import 'package:food_hub_app/screens/login/login_content.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: const SingleChildScrollView(
            child: LoginContent(),
          ),
        ),
      ),
    );
  }
}
