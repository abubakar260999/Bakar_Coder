// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  Contact({
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
    this.id,
    this.business,
    this.name,
    this.image1,
    this.street,
    this.city,
    this.email,
    this.phone,
    this.type,
    this.image2,
    this.mobile,
    this.fax,
    this.state,
    this.zip,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String the6;
  String the7;
  String the8;
  String the9;
  String the10;
  String the11;
  String the12;
  String the13;
  String id;
  String business;
  String name;
  String image1;
  String street;
  String city;
  String email;
  String phone;
  String type;
  String image2;
  String mobile;
  String fax;
  String state;
  String zip;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    the12: json["12"],
    the13: json["13"],
    id: json["id"],
    business: json["business"],
    name: json["name"],
    image1: json["image1"],
    street: json["street"],
    city: json["city"],
    email: json["email"],
    phone: json["phone"],
    type: json["type"],
    image2: json["image2"],
    mobile: json["mobile"],
    fax: json["fax"],
    state: json["state"],
    zip: json["zip"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12,
    "13": the13,
    "id": id,
    "business": business,
    "name": name,
    "image1": image1,
    "street": street,
    "city": city,
    "email": email,
    "phone": phone,
    "type": type,
    "image2": image2,
    "mobile": mobile,
    "fax": fax,
    "state": state,
    "zip": zip,
  };
}
