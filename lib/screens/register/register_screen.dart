import 'package:flutter/material.dart';
import 'package:food_hub_app/screens/register/register_content.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
            child: RegisterContent(),
          ),
        ),
      ),
    );
  }
}
