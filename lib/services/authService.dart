import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  ///La fonction login permet de se connecter via l'api
  static login(String email, String password) async{
    String type = "1";
    String url = "https://clo-express.000webhostapp.com/API/index.php";
    Map<String,String> body = {
      "email_connexion" : email,
      "password_connexion" : password,
      "type" : type
    };
    final response = await http.post(url,body: body);
    return jsonDecode(response.body);
  }

  ///la fonction register permet de s'inscrire via l'api
  static register(String nom,String prenom,String email,String numero,String password) async {
    String type = "2";
    String url = "https://clo-express.000webhostapp.com/API/index.php";
    Map<String,String> body = {
      "email_inscription" : email,
      "password_inscription" : password,
      "nom_inscription" : nom,
      "prenom_inscription" : prenom,
      "numero_inscription" : numero,
      "type" : type
    };
    final res = await http.post(url,body: body);
    return jsonDecode(res.body);
  }
}