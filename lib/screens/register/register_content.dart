import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/screens/register/widgets/register_form_widget.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../welcome/widgets/button_signin_widget.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _fullName;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void onPressSignUpButton() {
    if (_formState.currentState?.validate() == true) {
      context.showCustomFlashMessage(
        status: 'success',
        title: 'Registration Success!',
        positionBottom: false,
      );
      Future.delayed(const Duration(seconds: 2)).then(
        (_) => Navigator.pushNamed(
          context,
          Routes.loginScreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/header.png'),
              ],
            ),
            const SizedBox(height: 28.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 34,
                      color: preferenceSettingsProvider.isDarkTheme
                          ? grayColor50
                          : blackColor,
                    ),
                  ),
                  const SizedBox(height: 38.0),
                  Form(
                    key: _formState,
                    child: RegisterFormWidget(
                      fullNameController: _fullName,
                      emailController: _email,
                      passwordController: _password,
                    ),
                  ),
                  const SizedBox(height: 28.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42.0),
                    child: ButtonWidget(
                      onPress: () => onPressSignUpButton(),
                      title: 'SIGN UP',
                      buttonColor: orangeColor,
                      titleColor: whiteColor,
                      borderColor: orangeColor,
                      paddingHorizontal: 22.0,
                      paddingVertical: 22.0,
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: context.theme.textTheme.subtitle2!.copyWith(
                          color: preferenceSettingsProvider.isDarkTheme
                              ? whiteColor
                              : blackColor20,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.loginScreen,
                        ),
                        child: Text(
                          'Sign In',
                          style: context.theme.textTheme.subtitle2!.copyWith(
                            color: orangeColor,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: orangeColor,
                            decorationThickness: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: grayColor20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Text(
                            'sign up with',
                            style: theme.textTheme.subtitle2!.apply(
                                color: preferenceSettingsProvider.isDarkTheme
                                    ? whiteColor
                                    : blackColor20),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: grayColor20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  const ButtonSigninWith(
                    positionButtom: false,
                  ),
                  const SizedBox(height: 18.0),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
