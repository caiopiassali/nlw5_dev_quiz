import 'dart:convert';

import 'package:nlw5_dev_quiz/shared/models/answer_model.dart';

class QuestionModel {
  final String title;
  final List<AnswerModel> answers;

  QuestionModel({required this.title, required this.answers})
      : assert(answers.length == 4);

  factory QuestionModel.fromRawJson(String str) =>
      QuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        title: json["title"],
        answers: List<AnswerModel>.from(
            json["answers"].map((x) => AnswerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}
