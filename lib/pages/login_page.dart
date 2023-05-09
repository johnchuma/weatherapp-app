import 'package:app/controllers/auth_controller.dart';
import 'package:app/includes/custom_button.dart';
import 'package:app/includes/custom_form.dart';
import 'package:app/includes/custom_heading.dart';
import 'package:app/includes/custom_hint.dart';
import 'package:app/pages/registration_page.dart';
import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailOrPhoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool passwordHidden = true;
  @override
  Widget build(BuildContext context) {
    void togglePasswordVisibility() {
      setState(() {
        passwordHidden = !passwordHidden;
      });
    }

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/login.svg',
                      height: 180,
                      semanticsLabel: "Login",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                customHeading("Login"),
                customHint('Enter your credential below to continue'),
                const SizedBox(
                  height: 30,
                ),
                customForm("Email or phone number",
                    "Enter email or phone number", emailOrPhoneController),
                const SizedBox(
                  height: 20,
                ),
                customForm(
                    "Your password",
                    "Enter your password",
                    passwordController,
                    TextInputType.visiblePassword,
                    passwordHidden,
                    true,
                    togglePasswordVisibility),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AuthController().login(
                            passwordController.text,
                            emailOrPhoneController.text.contains('@')
                                ? null
                                : emailOrPhoneController.text,
                            emailOrPhoneController.text.contains('@')
                                ? emailOrPhoneController.text
                                : null);
                      }
                    },
                    child: customButton("LOGIN")),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => const Register());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customHint('Not registered ?'),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
