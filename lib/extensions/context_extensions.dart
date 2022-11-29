import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_app/widgets/widgets.dart';

extension ContextExtensions on BuildContext {
  void showCustomFlashMessage({
    String title = 'Coming Soon!',
    String message = 'We will notify you once this feature is ready 🙌',
    bool positionBottom = true,
    required String status,
  }) {
    showFlash(
      context: this,
      duration: const Duration(seconds: 2),
      builder: (_, controller) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: CustomFlashWidget(
            status: status,
            controller: controller,
            title: title,
            message: message,
            positionBottom: positionBottom,
          ),
        );
      },
    );
  }

  ThemeData get theme => Theme.of(this);
}
