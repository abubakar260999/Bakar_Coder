// To parse this JSON data, do
//
//     final companies = companiesFromJson(jsonString);

import 'dart:convert';

List<Map<String, String>> CompaniesFromJson(String str) => List<Map<String, String>>.from(json.decode(str).map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null  ?null : v))));

String CompaniesToJson(List<Map<String, String>> data) => json.encode(List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))));


class Companies {
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

  Companies(
      {this.id,
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

  Companies.fromJson(Map<String, dynamic> json) {
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