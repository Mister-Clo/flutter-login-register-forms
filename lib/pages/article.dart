import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_requests/model/articleModel.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/services/articleService.dart';
import 'package:http_requests/wrapper.dart';
import 'package:image_picker/image_picker.dart';

import '../home.dart';

class Article extends StatefulWidget {
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final _key = GlobalKey<FormState>();
  TextEditingController titre = new TextEditingController();
  TextEditingController descrip = new TextEditingController();

  File file;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String erreurImage = "";
  bool imgErr = false;

  void _chooseArticlePhoto() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Article Photo"),
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

  void getImage(ImageSource source) async {
    final pickedfile = await _picker.getImage(source: source, imageQuality: 50);
    if (pickedfile != null) {
      _imageFile = pickedfile;
      file = File(_imageFile.path);
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  void addArticle() async {
    if (_key.currentState.validate()) {
      if (file != null) {
        erreurImage = "";
        final response = await ArticleService.uploadArticle(file, titre.text,
            descrip.text, UserModel.currentuser.id.toString());
        print(response);
        if (response == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (g) => Wrapper()),
              (Route<dynamic> route) => false);
          setState(() {});
        } else {
          setState(() {});
        }
      } else {
        erreurImage = "Veuillez choisir une image pour l'article";
      }
    } else {
      if (file == null)
        erreurImage = "Veuillez choisir une image pour l'article";
      else
        erreurImage = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
      ),
      // backgroundColor: Color.fromRGBO(44, 44, 44, 0.6),
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Stack(
                            children: [
                              file == null
                                  ? Icon(
                                      Icons.image,
                                      size: 300,
                                      color: Colors.black26,
                                    )
                                  : Image.file(
                                      file,
                                      width: 300,
                                      height: 300,
                                    ),
                              //: NetworkImage(UserModel.currentuser.imageprofile),

                              Positioned(
                                  bottom: 125,
                                  right: 132,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      _chooseArticlePhoto();
                                    },
                                  )),
                            ],
                          ),
                        ),
                        if (erreurImage.isNotEmpty)
                          Text(
                            erreurImage,
                            style: TextStyle(color: Colors.amber[900]),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (e) =>
                              e.isEmpty ? "Veuillez entrer le titre" : null,
                          controller: titre,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 15),
                                child: Icon(
                                  Icons.title_rounded,
                                  size: 30,
                                ),
                              ),
                              labelText: 'titre',
                              hintText: "Titre de l'article"),
                          keyboardType: TextInputType.text,
                        ),
                        Text(" "),
                        TextFormField(
                          maxLines: 5,
                          validator: (e) => e.isEmpty
                              ? "Veuillez entrer la description"
                              : null,
                          controller: descrip,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 15),
                                child: Icon(
                                  Icons.description_rounded,
                                  size: 30,
                                ),
                              ),
                              labelText: "Décrivez l'article",
                              hintText: "description"),
                          keyboardType: TextInputType.text,
                        ),
                        Text(" "),
                        SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: addArticle,
                            color: Colors.lightBlueAccent,
                            child: Text(
                              'Ajouter',
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
