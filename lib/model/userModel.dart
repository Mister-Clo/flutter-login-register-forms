import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

///Le model pour le user
class UserModel {
  int id, isAdmin;
  String nom, prenom, email, num_tel, token, imageprofile;

  ///Le constructeur de la classe UserModel
  static UserModel currentuser;
  UserModel(
      {this.id,
      this.nom,
      this.email,
      this.isAdmin,
      this.num_tel,
      this.prenom,
      this.token,
      this.imageprofile});

  /// La fonction UserModel.fromJson(Map<String, dynamic> json)
  /// permet de convertir un objet json en un objet de type UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      num_tel: json['num_tel'],
      isAdmin: json['isAdmin'],
      token: json['token'],
      imageprofile: json['image']);

  ///La fonction toMap() renvoie un Mappage des
  ///attributs d'un objet UserModel
  Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "num_tel": num_tel,
        "isAdmin": isAdmin,
        "image": imageprofile,
        "token": token
      };

  static upload(File imageFiles) async {
    String url = "https://clo-express.000webhostapp.com/API/index.php";
    var steam =
        new http.ByteStream(DelegatingStream.typed(imageFiles.openRead()));
    var length = await imageFiles.length();
    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);

    var multipartfile = new http.MultipartFile("image", steam, length,
        filename: path.basename(imageFiles.path));
    request.fields['id'] = UserModel.currentuser.id.toString();
    request.fields['type'] = "3";
    request.files.add(multipartfile);
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Reussi");
        response.stream.transform(utf8.decoder).listen((v) {
          UserModel.saveUser(UserModel.fromJson(jsonDecode(v)));
        });
        return true;
      } else {
        print("Echec");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  ///fonction logout de deconnexion
  static logout(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentuser = null;
    await prefs.setString('user', null);
  }

  ///La fonction saveUser(UserModel user) permet d'écrire sur le disque
  ///les informations du user connecté
  static saveUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentuser = user;
    await prefs.setString('user', jsonEncode(user.toMap()));
  }

  ///La fonction getUser() permet de récupérer si présent
  ///un utilisateur enregistré sur le disque de l'appareil
  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user');
    if (data != null) {
      final res = jsonDecode(data);
      final user = UserModel.fromJson(res);
      currentuser = user;
      return user;
    }

    return null;
  }
}
