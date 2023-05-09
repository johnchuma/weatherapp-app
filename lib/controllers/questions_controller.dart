import 'package:app/models/answer.dart';
import 'package:app/models/question.dart';
import 'package:app/utils/boxes.dart';
import 'package:app/utils/endpoint.dart';
import 'package:app/utils/loader.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class QuestionController {
  void updateAnsweredQuestion(String questionId) async {
    try {
      await Dio().patch("$production/questions/update/$questionId",
          data: {"answered": true});
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.response);
    }
  }

  void answeredQuestions(userId) async {
    bool isLoading = false;

    try {
      var box = Boxes.getAnsweredQuestions();
      if (box.isEmpty) {
        Future.delayed(const Duration(milliseconds: 100)).then(((value) {
          showLoader();
          isLoading = true;
        }));
      }
      var response = await Dio().get("$production/questions/answered/$userId");

      List<Map<String, dynamic>> datas =
          List<Map<String, dynamic>>.from(response.data['body']);
      List<Question> questions = [];
      for (var data in datas) {
        var question = Question.fromJson(data['question']);
        question.answer = Answer.fromJson(data['answer']);
        questions.add(question);
      }
      await box.clear();
      await box.addAll(questions);
      if (isLoading) {
        Get.back();
      }
    } on DioError catch (e) {
      if (isLoading) {
        Get.back();
      }
      // ignore: avoid_print
      print(e.response);
    }
  }

  void unansweredQuestions(userId) async {
    bool isLoading = false;
    try {
      var box = Boxes.getUnansweredQuestions();
      if (box.isEmpty) {
        Future.delayed(const Duration(milliseconds: 100)).then(((value) {
          showLoader();
          isLoading = true;
        }));
      }
      var response =
          await Dio().get("$production/questions/unanswered/$userId");

      List<Map<String, dynamic>> datas =
          List<Map<String, dynamic>>.from(response.data['body']);
      List<Question> questions = [];

      for (var data in datas) {
        questions.add(Question.fromJson(data));
      }
      await box.clear();
      box.addAll(questions);
      if (isLoading) {
        Get.back();
      }
    } on DioError catch (e) {
      if (isLoading) {
        Get.back();
      }
      // ignore: avoid_print
      print(e.response);
    }
  }
}
