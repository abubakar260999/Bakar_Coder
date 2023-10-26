// To parse this JSON data, do
//
//     final taskManager = taskManagerFromJson(jsonString);

import 'dart:convert';

List<TaskManager> taskManagerFromJson(String str) => List<TaskManager>.from(json.decode(str).map((x) => TaskManager.fromJson(x)));

String taskManagerToJson(List<TaskManager> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskManager {
  TaskManager({
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
    this.startdate,
    this.name1,
    this.name2,
    this.name,
    this.files,
  });

  String id;
  dynamic departmentId;
  String owner;
  String assignBy;
  String subject;
  String description;
  String client;
  DateTime deadline;
  dynamic project;
  dynamic subproject;
  String priority;
  dynamic tasksubmission;
  dynamic forward;
  String status;
  DateTime date;
  DateTime startdate;
  String name1;
  String name2;
  dynamic name;
  List<String> files;

  factory TaskManager.fromJson(Map<String, dynamic> json) => TaskManager(
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
    startdate: json["startdate"] == null ? null : DateTime.parse(json["startdate"]),
    name1: json["name1"],
    name2: json["name2"],
    name: json["name"],
    files: List<String>.from(json["files"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
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
    "startdate": startdate == null ? null : startdate.toIso8601String(),
    "name1": name1,
    "name2": name2,
    "name": name,
    "files": List<dynamic>.from(files.map((x) => x)),
  };
}
