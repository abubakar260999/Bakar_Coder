// To parse this JSON data, do
//
//     final calls = callsFromJson(jsonString);

import 'dart:convert';

List<Calls> callsFromJson(String str) => List<Calls>.from(json.decode(str).map((x) => Calls.fromJson(x)));

String callsToJson(List<Calls> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calls {
  Calls({
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
    this.the18,
    this.the19,
    this.the20,
    this.the21,
    this.id,
    this.attender,
    this.subject,
    this.description,
    this.attachment,
    this.date,
    this.status,
    this.businessName,
    this.phone,
    this.email,
    this.fax1,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.type,
    this.callFor,
    this.phone2,
    this.time,
    this.attenderName,
    this.callForName,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  dynamic the4;
  DateTime the5;
  dynamic the6;
  String the7;
  dynamic the8;
  dynamic the9;
  dynamic the10;
  dynamic the11;
  dynamic the12;
  dynamic the13;
  dynamic the14;
  dynamic the15;
  String the16;
  String the17;
  String the18;
  String the19;
  String the20;
  String the21;
  String id;
  String attender;
  String subject;
  String description;
  dynamic attachment;
  DateTime date;
  dynamic status;
  String businessName;
  dynamic phone;
  dynamic email;
  dynamic fax1;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic zip;
  dynamic country;
  String type;
  String callFor;
  String phone2;
  String time;
  String attenderName;
  String callForName;

  factory Calls.fromJson(Map<String, dynamic> json) => Calls(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: DateTime.parse(json["5"]),
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    the12: json["12"],
    the13: json["13"],
    the14: json["14"],
    the15: json["15"],
    the16: json["16"],
    the17: json["17"],
    the18: json["18"],
    the19: json["19"],
    the20: json["20"],
    the21: json["21"],
    id: json["id"],
    attender: json["attender"],
    subject: json["subject"],
    description: json["description"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    businessName: json["business_name"],
    phone: json["phone"],
    email: json["email"],
    fax1: json["fax1"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    country: json["country"],
    type: json["type"],
    callFor: json["call_for"],
    phone2: json["phone2"],
    time: json["time"],
    attenderName: json["attender_name"],
    callForName: json["call_for_name"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5.toIso8601String(),
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12,
    "13": the13,
    "14": the14,
    "15": the15,
    "16": the16,
    "17": the17,
    "18": the18,
    "19": the19,
    "20": the20,
    "21": the21,
    "id": id,
    "attender": attender,
    "subject": subject,
    "description": description,
    "attachment": attachment,
    "date": date.toIso8601String(),
    "status": status,
    "business_name": businessName,
    "phone": phone,
    "email": email,
    "fax1": fax1,
    "address": address,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
    "type": type,
    "call_for": callFor,
    "phone2": phone2,
    "time": time,
    "attender_name": attenderName,
    "call_for_name": callForName,
  };
}
