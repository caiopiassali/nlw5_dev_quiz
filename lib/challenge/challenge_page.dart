import 'package:flutter/material.dart';
import 'package:nlw5_dev_quiz/challenge/challenge_controller.dart';
import 'package:nlw5_dev_quiz/challenge/widgets/next_button_widget.dart';
import 'package:nlw5_dev_quiz/challenge/widgets/question_indicator_widget.dart';
import 'package:nlw5_dev_quiz/challenge/widgets/quiz_widget.dart';
import 'package:nlw5_dev_quiz/result/result_page.dart';
import 'package:nlw5_dev_quiz/shared/models/question_model.dart';

class ChallengePage extends StatefulWidget {
  final String title;
  final List<QuestionModel> questions;

  ChallengePage({
    Key? key,
    required this.title,
    required this.questions,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final _controller = ChallengeController();
  final _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      _controller.currentPage = _pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    if (_controller.currentPage < widget.questions.length) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void onSelected(bool value) {
    if (value) {
      _controller.correctAnswers++;
    }

    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: _controller.currentPageNotifier,
                builder: (_, value, __) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: widget.questions
            .map((question) => QuizWidget(
                  question: question,
                  onSelected: onSelected,
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: _controller.currentPageNotifier,
            builder: (_, value, __) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (value < widget.questions.length)
                  Expanded(
                      child: NextButtonWidget.white(
                    label: 'Pular',
                    onTap: nextPage,
                  )),
                if (value == widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: 'Confirmar',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultPage(
                              title: widget.title,
                              correctAnswers: _controller.correctAnswers,
                              length: widget.questions.length,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
