import 'package:app/controllers/questions_controller.dart';
import 'package:app/includes/custom_hint.dart';
import 'package:app/includes/cutome_text2.dart';
import 'package:app/models/question.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/boxes.dart';
import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class AnsweredTab extends StatefulWidget {
  const AnsweredTab({super.key});

  @override
  State<AnsweredTab> createState() => _AnsweredTabState();
}

class _AnsweredTabState extends State<AnsweredTab> {
  @override
  void initState() {
    var box = Boxes.getUsers();
    User? me = box.get('me');
    QuestionController().answeredQuestions(me?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<Box<Question>>(
              valueListenable: Boxes.getAnsweredQuestions().listenable(),
              builder: (context, box, widget) {
                List<Question> hiveQuestions = box.values.toList();
                return Column(
                  children: hiveQuestions
                      .map((question) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  width: double.infinity,
                                  color: CustomColors.themeColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            customText2(question.question),
                                            customHint(
                                                'Your answer: ${question.answer.answer}'),
                                            customHint(
                                                "Correct answer: ${question.answer.correctAnswer.isEmpty ? 'waiting for player2' : question.answer.correctAnswer}")
                                          ],
                                        )),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            color: question.answer.correctAnswer
                                                    .isNotEmpty
                                                ? question.answer.isAccurate()
                                                    ? Colors.orange
                                                    : Colors.red
                                                : Colors.green,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: customText2(question.answer
                                                      .correctAnswer.isNotEmpty
                                                  ? question.answer.isAccurate()
                                                      ? "You won"
                                                      : "You lost"
                                                  : "Wait"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
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
