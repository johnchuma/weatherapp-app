import 'package:app/controllers/auth_controller.dart';
import 'package:app/includes/custom_button.dart';
import 'package:app/includes/custom_form.dart';
import 'package:app/includes/custom_heading.dart';
import 'package:app/includes/custom_hint.dart';
import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController repeatPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool passwordHidden = true;
  bool passwordHidden2 = true;

  @override
  Widget build(BuildContext context) {
    void togglePasswordVisibility() {
      setState(() {
        passwordHidden = !passwordHidden;
      });
    }

    void togglePasswordVisibility2() {
      setState(() {
        passwordHidden2 = !passwordHidden2;
      });
    }

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                customHeading("Create an account"),
                customHint('Fill the form below to create an account'),
                const SizedBox(
                  height: 30,
                ),
                customForm("Phone number", "Enter phone number",
                    phoneController, TextInputType.phone),
                const SizedBox(
                  height: 20,
                ),
                customForm(
                    "Email address", "Enter email address", emailController),
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
                customForm(
                    "Repeat password",
                    "Repeat your password",
                    repeatPasswordController,
                    TextInputType.visiblePassword,
                    passwordHidden2,
                    true,
                    togglePasswordVisibility2,
                    passwordController.text),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AuthController().register(emailController.text,
                            phoneController.text, passwordController.text);
                      }
                    },
                    child: customButton("REGISTER")),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customHint('Already registered ?'),
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
