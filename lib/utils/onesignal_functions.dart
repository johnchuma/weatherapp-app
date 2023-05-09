import 'package:dio/dio.dart';

Future sendNotification(
    List<String> tokenIdList, String contents, String heading) async {
  try {
    await Dio().post('https://onesignal.com/api/v1/notifications',
        options: Options(
            headers: {'Content-Type': 'application/json; charset=UTF-8'}),
        data: {
          "app_id": "59015f29-a888-4fff-bb47-61fd9aa6dce7",
          "include_player_ids": tokenIdList,
          "android_accent_color": "FF9976D2",
          "large_icon":
              "https://cdn-icons-png.flaticon.com/512/1779/1779940.png",
          "headings": {"en": heading},
          "contents": {"en": contents},
        });
  } on DioError catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
