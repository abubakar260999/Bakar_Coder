// To parse this JSON data, do
//
//     final individual = individualFromJson(jsonString);

import 'dart:convert';

List<Individual> individualFromJson(String str) => List<Individual>.from(json.decode(str).map((x) => Individual.fromJson(x)));

String individualToJson(List<Individual> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Individual {
  String s0;
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  String s8;
  String s9;
  String s10;
  String s11;
  String s12;
  String s13;
  String s14;
  String s15;
  String s16;
  String s17;
  String id;
  String fileReturnType;
  String firstname;
  String lastname;
  String ssn;
  String dob;
  String spouseFirstName;
  String spouseLastName;
  String spouseSsnNo;
  String spouseDob;
  String email;
  String address;
  String city;
  String state;
  String zip;
  String telephone;
  String type;
  String status;

  Individual(
      {this.s0,
        this.s1,
        this.s2,
        this.s3,
        this.s4,
        this.s5,
        this.s6,
        this.s7,
        this.s8,
        this.s9,
        this.s10,
        this.s11,
        this.s12,
        this.s13,
        this.s14,
        this.s15,
        this.s16,
        this.s17,
        this.id,
        this.fileReturnType,
        this.firstname,
        this.lastname,
        this.ssn,
        this.dob,
        this.spouseFirstName,
        this.spouseLastName,
        this.spouseSsnNo,
        this.spouseDob,
        this.email,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.telephone,
        this.type,
        this.status});

  Individual.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    s7 = json['7'];
    s8 = json['8'];
    s9 = json['9'];
    s10 = json['10'];
    s11 = json['11'];
    s12 = json['12'];
    s13 = json['13'];
    s14 = json['14'];
    s15 = json['15'];
    s16 = json['16'];
    s17 = json['17'];
    id = json['id'];
    fileReturnType = json['fileReturnType'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    ssn = json['ssn'];
    dob = json['dob'];
    spouseFirstName = json['spouse_first_name'];
    spouseLastName = json['spouse_last_name'];
    spouseSsnNo = json['spouse_ssn_no'];
    spouseDob = json['spouse_dob'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    telephone = json['telephone'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['7'] = this.s7;
    data['8'] = this.s8;
    data['9'] = this.s9;
    data['10'] = this.s10;
    data['11'] = this.s11;
    data['12'] = this.s12;
    data['13'] = this.s13;
    data['14'] = this.s14;
    data['15'] = this.s15;
    data['16'] = this.s16;
    data['17'] = this.s17;
    data['id'] = this.id;
    data['fileReturnType'] = this.fileReturnType;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['ssn'] = this.ssn;
    data['dob'] = this.dob;
    data['spouse_first_name'] = this.spouseFirstName;
    data['spouse_last_name'] = this.spouseLastName;
    data['spouse_ssn_no'] = this.spouseSsnNo;
    data['spouse_dob'] = this.spouseDob;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['telephone'] = this.telephone;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}