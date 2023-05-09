import 'package:app/models/answer.dart';
import 'package:app/models/user.dart';
import 'package:hive/hive.dart';
part 'question.g.dart';

@HiveType(typeId: 0)
class Question {
  @HiveField(0)
  late String question;
  @HiveField(1)
  late String id;
  @HiveField(2)
  late Answer answer = Answer("", "", "", "", "", User("", "", "", ""));
  Question(this.id, this.question, this.answer);
  Question.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    question = json['question'];
  }
}
