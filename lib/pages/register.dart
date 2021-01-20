import 'package:flutter/material.dart';
import 'package:http_requests/pages/login.dart';

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
  void register(){
    if(_key.currentState.validate()){

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
                        Image(image: AssetImage('images/add-user.png'),width: 150,),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer le nom":null,
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
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            validator: (e)=>e.isEmpty?"Veuillez entrer le numéro":null,
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
                            style: TextStyle(fontSize: 20),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.vpn_key,
                                    size: 30,
                                  ),
                                ),
                                labelText: 'Password',
                                hintText: "Mot de passe"),
                            keyboardType: TextInputType.text,
                          ),
                        ),
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
}
