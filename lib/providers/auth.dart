
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier{
    String _token = "";
    DateTime? _expiryDate;
    String _userId ="";

    String get token => _token ;
    DateTime get expiryDate => _expiryDate ?? DateTime(1991);
    String get userId => _userId;
    Future<void> signup(String email,String password) async {
      Uri url = Uri.parse("https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyCKF2E5TzRnms8wtHqhQnrsGOdcm4xGXis");
      var res = await http.post(url,body: json.encode({
        'email' : email,
        'password' : password,
        'returnSecureToken':true
      }));
      print(json.decode(res.body));
    }
    Future<void> signin(String email,String password) async {
      Uri url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCKF2E5TzRnms8wtHqhQnrsGOdcm4xGXis");
      var res = await http.post(url,body: json.encode({
        'email' : email,
        'password': password,
        'returnSecureToken': true
      }));
      print(json.decode(res.body));
    }
}