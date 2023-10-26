// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  Appointment({
    this.id,
    this.date,
    this.name,
    this.phone,
    this.description,
    this.status,
    this.company,
    this.time,
  });

  String id;
   String date;
  String name;
  String phone;
  String description;
  Status status;
  String company;
  String time;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    date: json["date"],
    name: json["name"],
    phone: json["phone"],
    description: json["description"],
    status: statusValues.map[json["status"]],
    company: json["company"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "name": name,
    "phone": phone,
    "description": description,
    "status": statusValues.reverse[status],
    "company": company,
    "time": time,
  };
}

enum DateEnum { THE_00000000000000 }

final dateEnumValues = EnumValues({
  "0000-00-00 00:00:00": DateEnum.THE_00000000000000
});

enum Status { NEW, FINISHED, DONE, RESCHEDULED, NOT_ATTENDED, EMPTY, STATUS_NEW }

final statusValues = EnumValues({
  "Done": Status.DONE,
  "": Status.EMPTY,
  "Finished": Status.FINISHED,
  "New": Status.NEW,
  "Not Attended": Status.NOT_ATTENDED,
  "Rescheduled": Status.RESCHEDULED,
  "new": Status.STATUS_NEW
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
