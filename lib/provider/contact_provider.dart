import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter_mobile/model/contact.dart';

class ContactProvider extends ChangeNotifier {
  bool loading = false;
  bool authenticated = false;
  List<Contact> contacts = [];

  Contact getContact(int index) {
    return contacts[index];
  }

  Future<void> getContacts() async {
    setLoading(true);
    try {
      final String response = await rootBundle.loadString('data.json');
      contacts = contactFromJson(await jsonDecode(response));
      print('contacts ${contacts.length}');
    } catch (e) {}
    setLoading(false);
  }

  void addContact(
      String firstName, String lastName, String email, String phoneNumber) {
    Contact contact = Contact(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber);
    contacts.add(contact);
    notifyListeners();
  }

  void updateContact(int index, String firstName, String lastName, String email,
      String phoneNumber) {
    contacts[index].firstName = firstName;
    contacts[index].lastName = lastName;
    contacts[index].email = email;
    contacts[index].phoneNumber = phoneNumber;
    notifyListeners();
  }

  void deleteContact(int index) {
    contacts.removeAt(index);
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }
}
