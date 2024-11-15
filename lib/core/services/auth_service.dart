import 'package:poke_flutter/core/models/user_credentials.dart';

class AuthService {
  AuthService();

  UserCredentials login(String username, String password){
    if(username.toLowerCase() == "luis" && password == "123"){
      return UserCredentials(token: "Luis-Token", username: username);
    }
    throw AssertionError("Wrong Credentials");
  }
}