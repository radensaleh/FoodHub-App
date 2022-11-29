import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';

class ButtonSigninWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final String icon;
  final Color buttonColor, titleColor, shadowColor;

  const ButtonSigninWidget({
    super.key,
    required this.onPress,
    required this.title,
    required this.buttonColor,
    required this.icon,
    required this.titleColor,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        alignment: Alignment.center,
        shadowColor: shadowColor,
        elevation: 1,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 18,
              height: 18,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.button?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
