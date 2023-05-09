import 'package:app/models/user.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/utils/boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WayPage extends StatelessWidget {
  const WayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Boxes.getUsers().listenable(),
      builder: (context, box, widget) {
        User? me = box.get('me');
        return me != null ? const HomePage() : const Login();
      },
    );
  }
}
