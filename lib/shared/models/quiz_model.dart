import 'dart:convert';

import 'package:nlw5_dev_quiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final int answeredQuestions;
  final String image;
  final Level level;

  QuizModel({
    required this.title,
    required this.questions,
    this.answeredQuestions = 0,
    required this.image,
    required this.level,
  }) : assert(questions.isNotEmpty);

  String get completed => '$answeredQuestions de ${questions.length}';

  double get percentage => answeredQuestions / questions.length;

  factory QuizModel.fromRawJson(String str) =>
      QuizModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        title: json["title"],
        image: json["image"],
        answeredQuestions: json["answeredQuestions"],
        level: json["level"].toString().toLevel(),
        questions: List<QuestionModel>.from(
            json["questions"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "answeredQuestions": answeredQuestions,
        "level": level.toLevelString(),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

extension LevelStringExtension on String {
  Level toLevel() => {
        'facil': Level.facil,
        'medio': Level.medio,
        'dificil': Level.dificil,
        'perito': Level.perito,
      }[this]!;
}

extension LevelExtension on Level {
  String toLevelString() => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito",
      }[this]!;
}
