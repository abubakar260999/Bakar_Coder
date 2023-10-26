// To parse this JSON data, do
//
//     final taskManager = taskManagerFromJson(jsonString);

import 'dart:convert';

List<TaskManager> taskManagerFromJson(String str) => List<TaskManager>.from(json.decode(str).map((x) => TaskManager.fromJson(x)));

String taskManagerToJson(List<TaskManager> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskManager {
  TaskManager({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.the10,
    this.the11,
    this.the12,
    this.the13,
    this.the14,
    this.the15,
    this.the16,
    this.the17,
    this.id,
    this.departmentId,
    this.owner,
    this.assignBy,
    this.subject,
    this.description,
    this.client,
    this.deadline,
    this.project,
    this.subproject,
    this.priority,
    this.tasksubmission,
    this.forward,
    this.status,
    this.date,
    this.to,
    this.name1,
    this.name2,
  });

  String the0;
  dynamic the1;
  dynamic the2;
  String the3;
  String the4;
  String the5;
  String the6;
  DateTime the7;
  dynamic the8;
  dynamic the9;
  dynamic the10;
  dynamic the11;
  dynamic the12;
  String the13;
  DateTime the14;
  String the15;
  String the16;
  String the17;
  String id;
  dynamic departmentId;
  dynamic owner;
  String assignBy;
  String subject;
  String description;
  String client;
  DateTime deadline;
  dynamic project;
  dynamic subproject;
  dynamic priority;
  dynamic tasksubmission;
  dynamic forward;
  String status;
  DateTime date;
  String to;
  String name1;
  String name2;

  factory TaskManager.fromJson(Map<String, dynamic> json) => TaskManager(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the7: DateTime.parse(json["7"]),
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    the12: json["12"],
    the13: json["13"],
    the14: DateTime.parse(json["14"]),
    the15: json["15"],
    the16: json["16"],
    the17: json["17"],
    id: json["id"],
    departmentId: json["department_id"],
    owner: json["owner"],
    assignBy: json["assign_by"],
    subject: json["subject"],
    description: json["description"],
    client: json["client"],
    deadline: DateTime.parse(json["deadline"]),
    project: json["project"],
    subproject: json["subproject"],
    priority: json["priority"],
    tasksubmission: json["tasksubmission"],
    forward: json["forward"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
    to: json["to"],
    name1: json["name1"],
    name2: json["name2"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7.toIso8601String(),
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12,
    "13": the13,
    "14": the14.toIso8601String(),
    "15": the15,
    "16": the16,
    "17": the17,
    "id": id,
    "department_id": departmentId,
    "owner": owner,
    "assign_by": assignBy,
    "subject": subject,
    "description": description,
    "client": client,
    "deadline": deadline.toIso8601String(),
    "project": project,
    "subproject": subproject,
    "priority": priority,
    "tasksubmission": tasksubmission,
    "forward": forward,
    "status": status,
    "date": date.toIso8601String(),
    "to": to,
    "name1": name1,
    "name2": name2,
  };
}
