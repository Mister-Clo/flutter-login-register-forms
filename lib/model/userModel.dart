import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  int id;
  String nom;
  String prenom;
  String email;
  String num_tel;
  int isAdmin;
  String token;
  static UserModel currentuser;
  UserModel({this.id,this.nom,this.email,this.isAdmin,this.num_tel,this.prenom,this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      num_tel: json['num_tel'],
      isAdmin: json['isAdmin'],
      token: json['token'],
    );
  }

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

  static saveUser(UserModel user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentuser = user;
    await prefs.setString('user', jsonEncode(user.toMap()));
  }

  static getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString('user');
    if (data!=null){
      final res = jsonDecode(data);
      final user = UserModel.fromJson(res);
      currentuser = user;
      return user;
    }

    return null;
  }

}