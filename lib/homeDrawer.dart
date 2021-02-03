import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/pages/article.dart';
import 'package:http_requests/pages/dashboard.dart';
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

  void getImage(ImageSource source) async {
    final pickedfile = await _picker.getImage(source: source, imageQuality: 50);
    if (pickedfile != null) {
      _imageFile = pickedfile;
      UserModel.upload(File(_imageFile.path));
      setState(() {});
      Navigator.of(context).pop();
    }
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
                onPressed: () async {
                  getImage(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () async {
                  getImage(ImageSource.gallery);
                },
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
                      UserModel.currentuser.imageprofile == null
                          ? CircleAvatar(
                              radius: 80.0,
                              backgroundImage: AssetImage('images/glogin.png'),
                              //: NetworkImage(UserModel.currentuser.imageprofile),
                              //: FileImage(File(_imageFile.path)),
                              backgroundColor: Colors.transparent,
                            )
                          : CachedNetworkImage(
                              height: 150,
                              width: 150,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              imageUrl: UserModel.currentuser.imageprofile,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                      Positioned(
                          bottom: 20,
                          right: 20,
                          child: InkWell(
                            child: Icon(Icons.camera_alt, size: 28),
                            onTap: () {
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
          leading: Icon(Icons.article_rounded),
          title: Text('Articles', style: TextStyle(fontSize: 18)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Article()));
          },
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Dashboard', style: TextStyle(fontSize: 18)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
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
