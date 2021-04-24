import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nlw5_dev_quiz/challenge/challenge_page.dart';
import 'package:nlw5_dev_quiz/core/core.dart';
import 'package:nlw5_dev_quiz/home/home_controller.dart';
import 'package:nlw5_dev_quiz/home/home_state.dart';
import 'package:nlw5_dev_quiz/home/widgets/app_bar_widget.dart';
import 'package:nlw5_dev_quiz/home/widgets/level_button_widget.dart';
import 'package:nlw5_dev_quiz/home/widgets/quiz_card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.loading)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );

    return Scaffold(
      appBar: AppBarWidget(user: controller.user!),
      body: Column(
        children: [
          SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...<String>['Fácil', 'Médio', 'Difícil', 'Perito']
                      .map((level) => LevelButtonWidget(label: level))
                      .toList(),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                children: controller.quizzes!
                    .map((quiz) => QuizCardWidget(
                          title: quiz.title,
                          completed: quiz.completed,
                          percentage: quiz.percentage,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChallengePage(
                                  title: quiz.title,
                                  questions: quiz.questions,
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
