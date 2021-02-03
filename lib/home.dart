import 'package:flutter/material.dart';
import 'package:http_requests/homeDrawer.dart';
import 'package:http_requests/model/articleModel.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/services/articleService.dart';
import 'package:http_requests/widgets/publication.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artillery'),
      ),
      drawer: Homedrawer(),
      body: FutureBuilder(
          future: ArticleService.getArticles(),
          builder: (_, s) {
            List<ArticleModel> pubs = s.data;
            if (pubs == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (pubs.length == 0) {
              return Center(
                child: Text("Aucune publication"),
              );
            } else {
              return ListView.builder(
                  itemCount: pubs.length,
                  itemBuilder: (_, i) {
                    return Publication(
                      article: pubs[i],
                    );
                  });
            }
          }),
    );
  }
}
