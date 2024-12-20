import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../gen/assets.gen.dart';
import '../../../router/router.dart';
import '../../config/config.dart';
import '../presentation.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ValueNotifier<bool> buttonActivityNotifier;
  late final ValueNotifier<bool> passwordVisibilityNotifier;
  late final TapGestureRecognizer creationTapGestureRecognizer;

  final userCubit = getIt<UserCubit>();

  @override
  void initState() {
    super.initState();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibilityNotifier = ValueNotifier(false);
    buttonActivityNotifier = ValueNotifier(false);
    creationTapGestureRecognizer = TapGestureRecognizer()
      ..onTap = openSignInScreen;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          Text(
            'Welcome!',
            style: context.theme.textTheme.displaySmall
                ?.copyWith(color: context.theme.primaryColor),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputFormField(
                          hintText: 'Email',
                          focusNode: emailFocusNode,
                          hasCancelButton: false,
                          textEditingController: emailController,
                          onInputChanged: (text) => onEmailChanged(text),
                          onInputCompleted: (text) async =>
                              onEmailChanged(text),
                        ),
                        SizedBox(height: 16.h),
                        ValueListenableBuilder<bool>(
                          valueListenable: passwordVisibilityNotifier,
                          builder: (_, isVisible, __) => InputFormField(
                            hintText: 'Password',
                            obscureText: !isVisible,
                            suffixIcon: isVisible
                                ? Assets.icons.eyeCrossed
                                : Assets.icons.eye,
                            focusNode: passwordFocusNode,
                            hasCancelButton: false,
                            onIconPressed: changePasswordVisibility,
                            textEditingController: passwordController,
                            validator: (text) => onPasswordChanged(text ?? ''),
                            onInputChanged: (text) => onPasswordChanged(text),
                            onInputCompleted: (text) async =>
                                onPasswordChanged(text),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        ValueListenableBuilder<bool>(
                          valueListenable: buttonActivityNotifier,
                          builder: (_, isEnabled, __) => BlocBuilder(
                            bloc: userCubit,
                            buildWhen: (_, UserState current) {
                              if (current is UserError) {
                                Fluttertoast.showToast(
                                  msg:
                                      'Error! Check your inputs and try again.',
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: const Color(0xFF7A0808),
                                );
                              } else if (current is UserUpdate &&
                                  current.hasAccount) {
                                context.pop();
                              }

                              return true;
                            },
                            builder: (_, state) {
                              final isInProgress = state == UserInProgress;

                              return FilledButton(
                                onPressed: (isEnabled && !isInProgress)
                                    ? () => userCubit.signUp(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        )
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isInProgress)
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    const Text('Sign up'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF333333),
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        style: context.theme.textTheme.bodyLarge?.copyWith(
                          color: context.theme.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: context.theme.primaryColor,
                        ),
                        recognizer: creationTapGestureRecognizer,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h + MediaQuery.viewInsetsOf(context).bottom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openSignInScreen() {
    context.router.replace(const SignInRoute());
  }

  String onEmailChanged(String text) {
    buttonActivityNotifier.value = false;

    final trimmed = text.trim();
    final isEmpty = trimmed.isEmpty;

    if (isEmpty) return 'This field is required!';

    final isValid = EmailValidator.validate(trimmed);

    if (!isValid) return 'Invalid email!';

    updateButtonActivity();
    return '';
  }

  String onPasswordChanged(String text) {
    buttonActivityNotifier.value = false;

    final trimmed = text.trim();

    final length = trimmed.length;

    passwordController.text = trimmed;

    if (length == 0) return 'This field is required!';
    if (length < 6) return 'Too short password!';

    updateButtonActivity();
    return '';
  }

  void changePasswordVisibility() {
    passwordVisibilityNotifier.value = !passwordVisibilityNotifier.value;
  }

  void updateButtonActivity() {
    final email = emailController.text.trim();
    final isEmailValid = EmailValidator.validate(email);
    final password = passwordController.text.trim();
    final isPasswordValid = password.length >= 6;

    buttonActivityNotifier.value = isEmailValid && isPasswordValid;
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordVisibilityNotifier.dispose();
    buttonActivityNotifier.dispose();

    super.dispose();
  }
}
