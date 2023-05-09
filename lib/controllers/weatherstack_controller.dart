import 'package:dio/dio.dart';

class WeatherstackController {
  Future<Map<String, dynamic>> getDaressalaamInfo() async {
    Map<String, dynamic>? info;
    try {
      var response = await Dio().get(
          "https://api.weatherstack.com/current?access_key=dcaa4cc25fea77bac4070f3a3470d8a2&query=Dar es salaam");
      info = Map<String, dynamic>.from(response.data);
      // ignore: empty_catches
    } catch (e) {}
    return info!;
  }
}
