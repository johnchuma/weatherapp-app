import 'package:app/models/user.dart';
import 'package:app/pages/way_page.dart';
import 'package:app/utils/boxes.dart';
import 'package:app/utils/endpoint.dart';
import 'package:app/utils/loader.dart';
import 'package:app/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthController {
  void register(String email, String phone, String password) async {
    try {
      showLoader();
      var status = await OneSignal.shared.getDeviceState();

      var box = Boxes.getUsers();
      var response = await Dio().post("$production/auth/register", data: {
        "email": email.trim(),
        "phone": phone.trim(),
        "password": password,
        "userToken": status?.userId
      });
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      User user = User.fromJson(data);
      box.put('me', user);

      OneSignal.shared.setExternalUserId(user.id);
      Get.back();

      Get.to(() => const WayPage());
    } on DioError catch (e) {
      Get.back();

      failureSnackbar(e);
    }
  }

  void logout() async {
    var box = Boxes.getUsers();
    await box.delete('me');
  }

  void login(String password, [String? phone, String? email]) async {
    try {
      showLoader();
      var box = Boxes.getUsers();
      var response = await Dio().post("$production/auth/login", data: {
        "phone": phone?.trim(),
        "email": email?.trim(),
        "password": password
      });
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      User user = User.fromJson(data);

      box.put('me', user);
      Get.back();
    } on DioError catch (e) {
      Get.back();
      failureSnackbar(e);
    }
  }
}
