// ignore_for_file: unused_import

import 'package:app/models/answer.dart';
import 'package:app/models/question.dart';
import 'package:app/models/user.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Question> getAnsweredQuestions() {
    return Hive.box<Question>('answeredQuestions');
  }

  static Box<Question> getUnansweredQuestions() {
    return Hive.box<Question>('unansweredQuestions');
  }

  static Box<User> getUsers() {
    return Hive.box<User>('users');
  }
}
