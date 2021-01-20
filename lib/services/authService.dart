import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static login(String email, String password) async{
    String type = "1";
    String url = "https://clo-express.000webhostapp.com/API/index.php";
    Map<String,String> body = {
      "email_connexion" : email,
      "password_connexion" : password,
      "type" : type
    };
    print(body);
    final response = await http.post(url,body: body);
    return jsonDecode(response.body);
  }
}