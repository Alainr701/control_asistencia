import 'package:aplication_salesiana/models/usuario.dart';
import 'package:aplication_salesiana/services/auth_methods.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> loginUser(String email, String password) async {
    String res =
        await AuthMethods().loginUser(email: email, password: password);

    return res == 'success' ? true : false;
  }
  //logout
  //signout tipo void
}
