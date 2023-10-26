// To parse this JSON data, do
//
//     final cooperation = cooperationFromJson(jsonString);

import 'dart:convert';

List<Map<String, String>> cooperationFromJson(String str) => List<Map<String, String>>.from(json.decode(str).map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v))));

String cooperationToJson(List<Map<String, String>> data) => json.encode(List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))));

class Cooperation {
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
  String s18;
  String s19;
  String s20;
  String s21;
  String s22;
  String s23;
  String s24;
  String s25;
  String s26;
  String id;
  String companyTitle;
  String ownerFirstName;
  String ownerLastName;
  String groupOfCompanies;
  String businessType;
  String scopeOfWork;
  String companyType;
  String ein;
  String dateOfIncorporation;
  String companyContact;
  String companyEmail;
  String companyFax;
  String companyWebsite;
  String yearend;
  String yearendDate;
  String lastfilingDate;
  String companyLicense;
  String companyPayroll;
  String companySalestax;
  String companyInsurance;
  String companyStatus;
  String createdBy;
  String createdOn;
  String updatedBy;
  String updatedOn;
  String type;

  Cooperation(
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
        this.s18,
        this.s19,
        this.s20,
        this.s21,
        this.s22,
        this.s23,
        this.s24,
        this.s25,
        this.s26,
        this.id,
        this.companyTitle,
        this.ownerFirstName,
        this.ownerLastName,
        this.groupOfCompanies,
        this.businessType,
        this.scopeOfWork,
        this.companyType,
        this.ein,
        this.dateOfIncorporation,
        this.companyContact,
        this.companyEmail,
        this.companyFax,
        this.companyWebsite,
        this.yearend,
        this.yearendDate,
        this.lastfilingDate,
        this.companyLicense,
        this.companyPayroll,
        this.companySalestax,
        this.companyInsurance,
        this.companyStatus,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.type});

  Cooperation.fromJson(Map<String, dynamic> json) {
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
    s18 = json['18'];
    s19 = json['19'];
    s20 = json['20'];
    s21 = json['21'];
    s22 = json['22'];
    s23 = json['23'];
    s24 = json['24'];
    s25 = json['25'];
    s26 = json['26'];
    id = json['id'];
    companyTitle = json['company_title'];
    ownerFirstName = json['owner_first_name'];
    ownerLastName = json['owner_last_name'];
    groupOfCompanies = json['group_of_companies'];
    businessType = json['business_type'];
    scopeOfWork = json['scope_of_work'];
    companyType = json['company_type'];
    ein = json['ein'];
    dateOfIncorporation = json['date_of_incorporation'];
    companyContact = json['company_contact'];
    companyEmail = json['company_email'];
    companyFax = json['company_fax'];
    companyWebsite = json['company_website'];
    yearend = json['yearend'];
    yearendDate = json['yearend_date'];
    lastfilingDate = json['lastfiling_date'];
    companyLicense = json['company_license'];
    companyPayroll = json['company_payroll'];
    companySalestax = json['company_salestax'];
    companyInsurance = json['company_insurance'];
    companyStatus = json['company_status'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    type = json['type'];
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
    data['18'] = this.s18;
    data['19'] = this.s19;
    data['20'] = this.s20;
    data['21'] = this.s21;
    data['22'] = this.s22;
    data['23'] = this.s23;
    data['24'] = this.s24;
    data['25'] = this.s25;
    data['26'] = this.s26;
    data['id'] = this.id;
    data['company_title'] = this.companyTitle;
    data['owner_first_name'] = this.ownerFirstName;
    data['owner_last_name'] = this.ownerLastName;
    data['group_of_companies'] = this.groupOfCompanies;
    data['business_type'] = this.businessType;
    data['scope_of_work'] = this.scopeOfWork;
    data['company_type'] = this.companyType;
    data['ein'] = this.ein;
    data['date_of_incorporation'] = this.dateOfIncorporation;
    data['company_contact'] = this.companyContact;
    data['company_email'] = this.companyEmail;
    data['company_fax'] = this.companyFax;
    data['company_website'] = this.companyWebsite;
    data['yearend'] = this.yearend;
    data['yearend_date'] = this.yearendDate;
    data['lastfiling_date'] = this.lastfilingDate;
    data['company_license'] = this.companyLicense;
    data['company_payroll'] = this.companyPayroll;
    data['company_salestax'] = this.companySalestax;
    data['company_insurance'] = this.companyInsurance;
    data['company_status'] = this.companyStatus;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['type'] = this.type;
    return data;
  }
}


