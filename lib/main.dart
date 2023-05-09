import 'package:app/models/answer.dart';
import 'package:app/models/question.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/splash_page.dart';
import 'package:app/pages/way_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setAppId("59015f29-a888-4fff-bb47-61fd9aa6dce7");
  await Hive.initFlutter();
  Hive.registerAdapter<Question>(QuestionAdapter());
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<Answer>(AnswerAdapter());

  await Hive.openBox<Question>('answeredQuestions');
  await Hive.openBox<Question>('unansweredQuestions');

  await Hive.openBox<User>('users');
  await Hive.openBox<Answer>('answers');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const WayPage();
            }
            return const SplashPage();
          })),
    );
  }
}
