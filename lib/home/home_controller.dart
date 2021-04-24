import 'package:flutter/foundation.dart';
import 'package:nlw5_dev_quiz/home/home_repository.dart';
import 'package:nlw5_dev_quiz/home/home_state.dart';
import 'package:nlw5_dev_quiz/shared/models/quiz_model.dart';
import 'package:nlw5_dev_quiz/shared/models/user_model.dart';

class HomeController {
  final _repository = HomeRepository();

  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);

  HomeState get state => stateNotifier.value;

  set state(HomeState state) => stateNotifier.value = state;

  UserModel? user;
  List<QuizModel>? quizzes;

  void getUser() async {
    state = HomeState.loading;

    user = await _repository.getUser();
    state = HomeState.success;
  }

  void getQuizzes() async {
    state = HomeState.loading;

    quizzes = await _repository.getQuizzes();
    state = HomeState.success;
  }
}
