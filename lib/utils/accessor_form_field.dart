import 'package:flutter/material.dart';

class AccesorFormFiled extends InheritedWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onPressSufixobscureTextIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String hintText;
  final bool showObscureToggle;
  final int maxLength;
  final int? maxLines;
  final bool darkTheme;

  const AccesorFormFiled({
    Key? key,
    required this.hintText,
    required Widget child,
    required this.controller,
    required this.darkTheme,
    this.validator,
    this.obscureText = false,
    this.showObscureToggle = false,
    this.maxLength = 30,
    this.maxLines,
    this.onPressSufixobscureTextIcon,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
  }) : super(key: key, child: child);

  static AccesorFormFiled? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AccesorFormFiled>());
  }

  @override
  bool updateShouldNotify(covariant AccesorFormFiled oldWidget) {
    return obscureText != oldWidget.obscureText;
  }
}
