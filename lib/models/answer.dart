import 'package:app/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'answer.g.dart';

@HiveType(typeId: 2)
class Answer {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String answer;
  @HiveField(2)
  late String userId;
  @HiveField(3)
  late String questionId;
  @HiveField(4)
  late String correctAnswer;
  @HiveField(5)
  late User user = User("", "", "", "");

  Answer(this.id, this.answer, this.userId, this.questionId, this.correctAnswer,
      this.user);

  bool isAccurate([int? weatherStackAnswer]) {
    bool accurate = false;
    if (correctAnswer.isEmpty) {
      int apiAnswer = weatherStackAnswer!;
      int userAnswer = int.parse(answer);
      var accuracyRange = [-2, 1, 0, 1, 2];
      if (accuracyRange.contains(apiAnswer - userAnswer)) {
        accurate = true;
      }
    } else {
      int apiAnswer = int.parse(correctAnswer);
      int userAnswer = int.parse(answer);
      var accuracyRange = [-2, 1, 0, 1, 2];
      if (accuracyRange.contains(apiAnswer - userAnswer)) {
        accurate = true;
      }
    }
    return accurate;
  }

  Answer.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    answer = json["answer"];
    userId = json["userId"];
    questionId = json["questionId"];
    correctAnswer = json["correctAnswer"].toString();
  }
}
