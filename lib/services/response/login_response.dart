import 'package:googlemapsflutter/services/request/login_request.dart';
import 'package:googlemapsflutter/models/User/user.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user); //user döndürecek
  void onLoginError(String error); //error döndürecek
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)  //login girişi
        .then((user) => _callBack.onLoginSuccess(user)) //login başarılı kontrol
        .catchError((onError) => _callBack.onLoginError(onError.toString())); //login başarısız kontrol
  } 
}