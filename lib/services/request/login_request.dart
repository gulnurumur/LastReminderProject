import 'dart:async';
import 'package:googlemapsflutter/models/User/user.dart';
import 'package:googlemapsflutter/data/Query/login_query.dart';

class LoginRequest {
  LoginQuery con = new LoginQuery();

 Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username,password);
    return result;
  }
}