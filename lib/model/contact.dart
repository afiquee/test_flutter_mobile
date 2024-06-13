import 'dart:convert';

List<Contact> contactFromJson(List<dynamic> json) =>
    List<Contact>.from(json.map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? phoneNumber;

  Contact({this.id, this.firstName, this.lastName, this.email, this.dob, this.phoneNumber});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    dob = json['dob'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}