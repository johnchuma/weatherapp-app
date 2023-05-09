import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/question.dart';
import 'package:app/pages/home_tabs/answered.dart';
import 'package:app/pages/home_tabs/unaswered.dart';
import 'package:app/utils/boxes.dart';
import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Map<String, dynamic>> tabs = [
  {'tab': 'Unanswered questions', 'screen': const UnansweredTab()},
  {'tab': 'Answered questions', 'screen': const AnsweredTab()}
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: CustomColors.backgroundColor,
          leading: Container(),
          leadingWidth: 1,
          title: const Text("Weatherquiz"),
          actions: [
            GestureDetector(
                onTap: () {
                  var box = Boxes.getAnsweredQuestions();
                  List<Question> questions = box.values.toList();
                  int point = 0;
                  for (var question in questions) {
                    if (question.answer.isAccurate()) {
                      point++;
                    }
                  }

                  Get.defaultDialog(
                      title: 'Earned points',
                      content: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.star, color: Colors.orange),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 50,
                              ),
                              Icon(Icons.star, color: Colors.orange),
                            ],
                          ),
                          Text(
                            "$point",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ));
                },
                // ignore: prefer_const_constructors
                child: Icon(
                  Icons.card_giftcard,
                  size: 20,
                )),
            PopupMenuButton(
                itemBuilder: ((context) => [
                      PopupMenuItem(
                          onTap: () {
                            AuthController().logout();
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.logout,
                                size: 15,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ))
                    ])),
            const SizedBox(
              width: 0,
            )
          ],
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: GoogleFonts.poppins(fontSize: 14),
              indicatorColor: Colors.white30,
              isScrollable: true,
              tabs: tabs
                  .map((item) => Tab(
                        text: "${item['tab']}",
                      ))
                  .toList()),
        ),
        body: TabBarView(
            children: tabs
                .map((item) => Container(
                      child: item['screen'],
                    ))
                .toList()),
      ),
    );
  }
}
