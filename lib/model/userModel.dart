class UserModel {
  int id;
  String nom;
  String prenom;
  String email;
  String num_tel;
  int isAdmin;
  String token;

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

}