import 'package:http_requests/model/userModel.dart';

class ArticleModel {
  // ignore: non_constant_identifier_names
  int id_pub;
  UserModel user;
  String title, descrip, photo;

  ///Le constructeur de la classe ArticleModel
  ArticleModel({this.id_pub, this.descrip, this.photo, this.title, this.user});

  /// La fonction UserModel.fromJson(Map<String, dynamic> json)
  /// permet de convertir un objet json en un objet de type ArticleModel
  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
      id_pub: json['id_pub'],
      descrip: json['descrip'],
      photo: json['photo'],
      title: json['title'],
      user: UserModel.fromJson(json));

  ///La fonction toMap() renvoie un Mappage des
  ///attributs d'un objet ArticleModel
  Map<String, dynamic> toMap() => {
        "id_pub": id_pub,
        "descrip": descrip,
        "title": title,
        "photo": photo,
      };
}
