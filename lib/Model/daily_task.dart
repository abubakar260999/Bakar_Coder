// To parse this JSON data, do
//
//     final dailyTask = dailyTaskFromJson(jsonString);

import 'dart:convert';

List<DailyTask> dailyTaskFromJson(String str) => List<DailyTask>.from(json.decode(str).map((x) => DailyTask.fromJson(x)));

String dailyTaskToJson(List<DailyTask> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyTask {
  DailyTask({
    this.id,
    this.title,
    this.note,
    this.start,
    this.end,
    this.status,
    this.file,
    this.user,
    this.date,
    this.name,
  });

  String id;
  String title;
  String note;
  String start;
  String end;
  String status;
  dynamic file;
  String user;
  DateTime date;
  String name;

  factory DailyTask.fromJson(Map<String, dynamic> json) => DailyTask(
    id: json["id"],
    title: json["title"],
    note: json["note"],
    start: json["start"] == null ? null : json["start"],
    end: json["end"] == null ? null : json["end"],
    status: json["status"] == null ? null : json["status"],
    file: json["file"],
    user: json["user"],
    date: DateTime.parse(json["date"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "note": note,
    "start": start == null ? null : start,
    "end": end == null ? null : end,
    "status": status == null ? null : status,
    "file": file,
    "user": user,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "name": name,
  };
}
