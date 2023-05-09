import 'package:app/controllers/answers_controller.dart';
import 'package:app/controllers/questions_controller.dart';
import 'package:app/includes/answer_form.dart';
import 'package:app/includes/custom_button.dart';
import 'package:app/includes/cutome_text2.dart';
import 'package:app/models/question.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/boxes.dart';
import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class UnansweredTab extends StatefulWidget {
  const UnansweredTab({super.key});

  @override
  State<UnansweredTab> createState() => _UnansweredTabState();
}

class _UnansweredTabState extends State<UnansweredTab> {
  User? me;
  @override
  void initState() {
    var box = Boxes.getUsers();
    me = box.get('me');
    QuestionController().unansweredQuestions(me?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    TextEditingController answerController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<Box<Question>>(
              valueListenable: Boxes.getUnansweredQuestions().listenable(),
              builder: (context, box, widget) {
                List<Question> hiveQuestions = box.values.toList();
                return Column(
                  children: hiveQuestions
                      .map((question) => GestureDetector(
                            onTap: () {
                              Get.bottomSheet(Container(
                                color: CustomColors.backgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 5,
                                              width: 50,
                                              color: Colors.white12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          answerForm(
                                              "Question's answer",
                                              "Enter question's answer",
                                              answerController,
                                              TextInputType.number),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  Get.back();
                                                  AnswersController()
                                                      .answerQuestion(
                                                          me!,
                                                          question,
                                                          answerController
                                                              .text);
                                                }
                                              },
                                              child: customButton('Submit')),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                    width: double.infinity,
                                    color: CustomColors.themeColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: customText2(question.question),
                                    )),
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            )),
      ),
    );
  }
}
