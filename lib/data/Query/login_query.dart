import 'dart:async';
import 'package:googlemapsflutter/models/User/user.dart';
import 'package:googlemapsflutter/data/database_helper.dart';

class LoginQuery{
  DatabaseHelper con = new DatabaseHelper(); //connection nesnesi

  //insert 
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap()); //(table,values)
    return res;
  }

  //delete
  Future<int> deleteUser (User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res; 
  }

  //login girişi 
  Future<User> getLogin (String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM user WHERE username= '$user' and password='$password'");

    if(res.length > 0){
      return new User.fromMap(res.first);
    }
    return null;
  }

  //Kullanıcıları listeleme
  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");

    List<User> list = res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList():null;
    return list;
  }
}
