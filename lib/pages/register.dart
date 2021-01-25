import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/pages/login.dart';
import 'package:http_requests/services/authService.dart';

import '../home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email_inscription = new TextEditingController();
  TextEditingController nom_inscription = new TextEditingController();
  TextEditingController prenom_inscription = new TextEditingController();
  TextEditingController numero_inscription = new TextEditingController();
  TextEditingController password_inscription = new TextEditingController();
  final _key = GlobalKey<FormState>();
  String message = "";
  bool registered = false;

  ///la fonction login appelle la fonction de L'api d'inscription
  ///register
  void register() async{
    if(_key.currentState.validate()){
      final response = await AuthService.register(
          nom_inscription.text,prenom_inscription.text,
          email_inscription.text,numero_inscription.text,
          password_inscription.text);
      if(response["statut"]==1){
        await UserModel.saveUser(UserModel.fromJson(response));
        registered = true;
        message = response["message"];
        //Navigator.of(context).push(MaterialPageRoute(builder: (g)=> Home()));
        setState(() {});
      }else{
        registered = false;
        message = response["message"];
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 44, 44, 0.6),
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Image(image: AssetImage('images/add-user.png'),width: 150),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer le nom":null,
                            controller: nom_inscription,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                ),
                                labelText: 'Nom',
                                hintText: "Votre nom"),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer le prénom":null,
                            controller: prenom_inscription,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.person_add,
                                    size: 30,
                                  ),
                                ),
                                labelText: 'Prenom',
                                hintText: "Votre prénom"),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer l'email":null,
                            controller: email_inscription,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.email,
                                    size: 30,
                                  ),
                                ),
                                labelText: 'Email',
                                hintText: "e-mail"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer le numéro":null,
                            controller: numero_inscription,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.phone,
                                    size: 30,
                                  ),
                                ),
                                labelText: 'Téléphone',
                                hintText: "numéro de tel"),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer le mot de passe":null,
                            controller: password_inscription,
                            style: TextStyle(fontSize: 20),
                            obscureText: visible,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.vpn_key,
                                    size: 30,
                                  ),
                                ),
                                suffixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: IconButton(
                                      icon: visible ? FaIcon(FontAwesomeIcons.eye,size: 25,) : FaIcon(FontAwesomeIcons.eyeSlash,size: 25,) ,
                                      onPressed: toggle_password,
                                    )
                                ),
                                labelText: 'Password',
                                hintText: "Mot de passe"),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Text("$message", style: TextStyle(color: registered ? Colors.greenAccent : Colors.redAccent),),
                        SizedBox(
                          height: 44,
                          child: RaisedButton(onPressed: register,
                            color: Colors.lightBlueAccent,
                            child: Text('Register',
                              style: TextStyle(fontSize: 19, color: Colors.white),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Avez-vous un compte?",
                                style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
                            FlatButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>Login()
                                  ));
                                },
                                child: Text('Login',
                                    style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold)
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ))),
    );
  }
  bool visible = true;
  ///la fonction toggle_password permet de basculer l'icône
  ///de visibilité de mot de passe au clic
  void toggle_password(){
    visible = !visible;
    setState(() {});
  }
}
