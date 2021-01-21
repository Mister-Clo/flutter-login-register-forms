import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///Le model pour le user
class UserModel {
  int id,isAdmin;
  String nom,prenom,email,num_tel,token;

  ///Le constructeur de la classe UserModel
  static UserModel currentuser;
  UserModel({this.id,this.nom,this.email,this.isAdmin,this.num_tel,this.prenom,this.token});

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
    );

  ///La fonction toMap() renvoie un Mappage des
  ///attributs d'un objet UserModel
   Map<String,dynamic> toMap(){
    return {
      "id" : id,
      "nom" : nom,
      "prenom" : prenom,
      "email" : email,
      "num_tel" : num_tel,
      "isAdmin" : isAdmin,
      "token" : token
    };
  }

  ///La fonction saveUser(UserModel user) permet d'écrire sur le disque
  ///les informations du user connecté
  static saveUser(UserModel user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentuser = user;
    await prefs.setString('user', jsonEncode(user.toMap()));
  }

  ///La fonction getUser() permet de récupérer si présent
  ///un utilisateur enregistré sur le disque de l'appareil
  static getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString('user');
    /*if (data!=null){
      final res = jsonDecode(data);
      final user = UserModel.fromJson(res);
      currentuser = user;
      return user;
    }*/

    return null;
  }

}