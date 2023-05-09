import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String phone;
  @HiveField(3)
  late String userToken;

  User(this.id, this.email, this.phone, this.userToken);
  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    phone = json['phone'];
    userToken = json['userToken'];
  }
}
