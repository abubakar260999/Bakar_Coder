// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Comment {
  Comment({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.id,
    this.taskId,
    this.userId,
    this.text,
    this.date,
    this.name,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  DateTime the4;
  String the5;
  String id;
  String taskId;
  String userId;
  String text;
  DateTime date;
  String name;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: DateTime.parse(json["4"]),
    the5: json["5"],
    id: json["id"],
    taskId: json["task_id"],
    userId: json["user_id"],
    text: json["text"],
    date: DateTime.parse(json["date"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4.toIso8601String(),
    "5": the5,
    "id": id,
    "task_id": taskId,
    "user_id": userId,
    "text": text,
    "date": date.toIso8601String(),
    "name": name,
  };
}
