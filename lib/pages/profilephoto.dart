import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/pages/register.dart';
import 'package:http_requests/services/authService.dart';
import 'package:image_picker/image_picker.dart';

import '../home.dart';

class Profilephoto extends StatefulWidget {
  @override
  _ProfilephotoState createState() => _ProfilephotoState();
}

class _ProfilephotoState extends State<Profilephoto> {
  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
        title: Text("Profile Photo"),
      ),
      backgroundColor: Color.fromRGBO(44, 44, 44, 0.6),
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('images/glogin.png'),
                        ),
                        Text(
                          " "
                        ),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 44,
                              child: RaisedButton(
                                onPressed: (){},
                                color: Colors.lightBlueAccent,
                                child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Import picture',
                                    style:
                                    TextStyle(fontSize: 19, color: Colors.white),
                                  ),
                                  Icon(Icons.add_photo_alternate)
                                ],
                              ),
                              ),
                            ),
                            SizedBox(
                              height: 44,
                              child: RaisedButton(
                                onPressed: (){},
                                color: Colors.lightBlueAccent,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Camera',
                                      style:
                                      TextStyle(fontSize: 19, color: Colors.white),
                                    ),
                                    Icon(Icons.add_a_photo_rounded)
                                  ],
                                ),

                              ),
                            ),
                          ],
                          ),
                      ],
                    ),
                  )))),
    );
  }

  bool visible = true;

  ///la fonction toggle_password permet de basculer l'icône
  ///de visibilité de mot de passe au clic
  void toggle_password() {
    visible = !visible;
    setState(() {});
  }
}
