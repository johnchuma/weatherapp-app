// ignore_for_file: avoid_print, duplicate_ignore

import 'package:app/controllers/questions_controller.dart';
import 'package:app/controllers/weatherstack_controller.dart';
import 'package:app/models/answer.dart';
import 'package:app/models/question.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/endpoint.dart';
import 'package:app/utils/loader.dart';
import 'package:app/utils/onesignal_functions.dart';
import 'package:app/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AnswersController {
  List keywords = [
    'temperature',
    'humidity',
    'cloudcover',
    'wind_speed',
    'visibility'
  ];

  void updateAnswer(Answer answer, correctAnswer) async {
    try {
      await Dio().patch("$production/answers/${answer.id}", data: {
        "correctAnswer": correctAnswer,
      });
    } on DioError catch (e) {
      print(e.response);
    }
  }

  void answerQuestion(User user, Question question, answer) async {
    try {
      showLoader();
      var response = await Dio().post("$production/answers/", data: {
        "answer": int.parse(answer).toString(),
        "userId": user.id,
        "questionId": question.id
      });
      if (response.data["completed"]) {
        List<Map<String, dynamic>> datas =
            List<Map<String, dynamic>>.from(response.data["answers"]);
        List<Answer> answers = [];

        for (var data in datas) {
          Answer answer = Answer.fromJson(data["answer"]);
          answer.user = User.fromJson(data['user']);
          answers.add(answer);
        }
        WeatherstackController().getDaressalaamInfo().then((value) => {
              for (var keyword in keywords)
                {
                  if (question.question.contains(keyword))
                    {
                      for (var answer in answers)
                        {
                          print(answer.isAccurate(value["current"][keyword])),
                          print(value["current"][keyword]),
                          if (answer.isAccurate(value["current"][keyword]))
                            {
                              sendNotification([
                                answer.user.userToken
                              ], "You have won and recieved 1 point from weatherquiz",
                                  "Congratulations")
                            }
                          else
                            {
                              sendNotification(
                                  [answer.user.userToken],
                                  "You have lost 1 point from weatherquiz ",
                                  "Oops! sorry")
                            },
                          updateAnswer(answer, value["current"][keyword])
                        }
                    }
                },
            });
        QuestionController().unansweredQuestions(user.id);
        Get.back();
        successSnackbar("Success", "Your answer is submitted successfully");
        QuestionController().answeredQuestions(user.id);
        QuestionController().updateAnsweredQuestion(question.id);
      } else {
        Get.back();
        successSnackbar("Success", "Your answer is submitted successfully");
        QuestionController().unansweredQuestions(user.id);
      }
    } on DioError catch (e) {
      Get.back();
      failureSnackbar(e);
      // ignore: avoid_print
      print(e);
    }
  }
}
