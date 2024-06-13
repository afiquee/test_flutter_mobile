import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool loading = false;
  bool authenticated = false;


  Future<void> authenticate(username, password) async {
    setLoading(true);
  }


  void verifyAuth() async {
   
  }

  void logout() async {
    
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

}
