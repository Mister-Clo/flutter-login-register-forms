import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/wrapper.dart';
import 'package:image_picker/image_picker.dart';


import 'model/userModel.dart';

class Homedrawer extends StatefulWidget {
  @override
  _HomedrawerState createState() => _HomedrawerState();
}

class _HomedrawerState extends State<Homedrawer> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  
  void getImage(ImageSource source) async{
    final pickedfile = await _picker.getImage(source: source);
      _imageFile = pickedfile;
      UserModel.currentuser.imageprofile = _imageFile.path;
      print( UserModel.currentuser.imageprofile);
    //final appDir = await syspaths.getApplicationDocumentsDirectory();
      print("");
    setState(() {

    });
    Navigator.of(context).pop();
  }

  void _ChooseProfilePhoto() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Profile Photo"),
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.camera_alt),
                onPressed: () async { getImage(ImageSource.camera);},
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () async { getImage(ImageSource.gallery);},
                label: Text("Gallery"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 5),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80.0,
                        backgroundImage: _imageFile==null
                            ?AssetImage('images/glogin.png')
                            : FileImage(File(_imageFile.path)) ,
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                          bottom: 20,
                          right: 20,
                          child: InkWell(
                            child: Icon(Icons.camera_alt, size: 28),
                            onTap: () {
                              print("hallo");
                              _ChooseProfilePhoto();
                            },
                          )),
                    ],
                  ),
                ),
                Text(
                  "${UserModel.currentuser.nom} ${UserModel.currentuser.prenom}",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Text(
                  "${UserModel.currentuser.email}",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.user),
          title: Text('Profil', style: TextStyle(fontSize: 18)),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Paramètres', style: TextStyle(fontSize: 18)),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text('Se déconnecter', style: TextStyle(fontSize: 18)),
          onTap: () {
            UserModel.logout(UserModel.currentuser);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Wrapper()));
          },
        ),
      ],
    ));
  }
}
