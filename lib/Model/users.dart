// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.id,
    this.email,
    this.password,
    this.name,
    this.contact,
    this.role,
    this.address,
    this.designation,
    this.department,
    this.newrole,
    this.status,
  });

  String id;
  String email;
  String password;
  String name;
  String contact;
  String role;
  String address;
  String designation;
  String department;
  String newrole;
  Status status;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    contact: json["contact"],
    role: json["role"],
    address: json["address"] == null ? null : json["address"],
    designation: json["designation"],
    department: json["department"],
    newrole: json["newrole"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "contact": contact,
    "role": roleValues.reverse[role],
    "address": address == null ? null : address,
    "designation": designation,
    "department": department,
    "newrole": newrole,
    "status": statusValues.reverse[status],
  };
}

enum Role { ADMIN, USER, MIN }

final roleValues = EnumValues({
  "admin": Role.ADMIN,
  "min": Role.MIN,
  "user": Role.USER
});

enum Status { ACTIVE, IN_ACTIVE }

final statusValues = EnumValues({
  "Active": Status.ACTIVE,
  "In Active": Status.IN_ACTIVE
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
