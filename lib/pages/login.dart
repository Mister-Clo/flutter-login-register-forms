import 'package:flutter/material.dart';
import 'package:http_requests/home.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/pages/register.dart';
import 'package:http_requests/services/authService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 TextEditingController email = new TextEditingController();
 TextEditingController password = new TextEditingController();
 final _key = GlobalKey<FormState>();
 String message = "";
 bool connected = false;
 void login() async{
   if(_key.currentState.validate()){
       final response =  await AuthService.login(email.text, password.text);
       if(response["statut"]==1){
         await UserModel.saveUser(UserModel.fromJson(response));
         connected = true;
         message = response["message"];
         Navigator.of(context).push(MaterialPageRoute(builder: (g)=> Home()));
         setState(() {});
       }else{
         connected = false;
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
              Image(image: AssetImage('images/glogin.png'),width: 150,),
              Card(
                child: TextFormField(
                  validator: (e)=>e.isEmpty?"Veuillez entrer l'email":null,
                  controller: email,
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
                  validator: (e)=>e.isEmpty?"Veuillez entrer le mot de passe":null,
                  controller: password,
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
              Text("$message", style: TextStyle(color: connected ? Colors.greenAccent : Colors.redAccent),),
              FlatButton(
                  onPressed: (){},
                  child: Text('Forgot password ?',
                      style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold)
                  )
              ),
              SizedBox(
                height: 44,
                child: RaisedButton(onPressed: login,
                  color: Colors.lightBlueAccent,
                  child: Text('Login',
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
                          builder: (context)=>Register()
                        ));
                      },
                      child: Text('Sign up',
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
  void toggle_password(){
   visible = !visible;
   setState(() {

   });
  }
}
