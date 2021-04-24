import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nlw5_dev_quiz/shared/models/quiz_model.dart';
import 'package:nlw5_dev_quiz/shared/models/user_model.dart';

class HomeRepository {
  Future<UserModel> getUser() async {
    final response = await rootBundle.loadString('assets/database/user.json');

    return UserModel.fromRawJson(response);
  }

  Future<List<QuizModel>> getQuizzes() async {
    final response =
        await rootBundle.loadString('assets/database/quizzes.json');
    final list = jsonDecode(response) as List;

    return list.map((quiz) => QuizModel.fromJson(quiz)).toList();
  }
}
