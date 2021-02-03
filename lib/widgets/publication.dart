import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http_requests/model/articleModel.dart';
import 'package:http_requests/model/userModel.dart';

class Publication extends StatelessWidget {
  final ArticleModel article;
  Publication({this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black38)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      article.photo != null
                          ? Container(
                              margin: EdgeInsets.only(left: 5, right: 4),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          article.photo))),
                            )
                          : Icon(
                              Icons.image,
                              size: 180,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              article.descrip,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Divider(
                      color: Colors.black87,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(bottom: 1),
                    leading: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: CachedNetworkImageProvider(
                          UserModel.currentuser.imageprofile),
                      // backgroundImage: AssetImage('images/glogin.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(article.user.nom + ' ' + article.user.prenom),
                    subtitle: Text(article.user.email),
                    trailing:
                        IconButton(icon: Icon(Icons.edit), onPressed: null),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
