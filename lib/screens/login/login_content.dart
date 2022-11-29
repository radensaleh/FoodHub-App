import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../welcome/widgets/button_signin_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void onPressSignInButton() {
    if (_formState.currentState?.validate() == true) {
      context.showCustomFlashMessage(
        status: 'success',
        title: 'Login Success!',
        positionBottom: false,
      );
      Future.delayed(const Duration(seconds: 1)).then(
        (_) => Navigator.pushNamed(
          context,
          Routes.homeScreen,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 37,
                    left: 27,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    enableFeedback: false,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: blackColor80,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 92.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
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
                    child: LoginFormWidget(
                      emailController: _email,
                      passwordController: _password,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: InkWell(
                      onTap: () =>
                          context.showCustomFlashMessage(status: 'info'),
                      child: Text(
                        'Forgot password?',
                        style: context.theme.textTheme.subtitle2!.copyWith(
                          color: orangeColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42.0),
                    child: ButtonWidget(
                      onPress: () => onPressSignInButton(),
                      title: 'LOGIN',
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
                        "Don't have an account?",
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
                          Routes.registerScreen,
                        ),
                        child: Text(
                          'Sign Up',
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
                            'sign in with',
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
            )
          ],
        );
      },
    );
  }
}
