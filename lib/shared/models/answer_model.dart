import 'dart:convert';

class AnswerModel {
  final String title;
  final bool isRight;

  AnswerModel({required this.title, this.isRight = false});

  factory AnswerModel.fromRawJson(String str) =>
      AnswerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        title: json["title"],
        isRight: json["isRight"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "isRight": isRight,
      };
}
