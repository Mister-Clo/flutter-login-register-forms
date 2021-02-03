import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:http_requests/model/articleModel.dart';
import 'package:http_requests/widgets/publication.dart';
import 'package:path/path.dart' as path;

class ArticleService {
  ///La fonction upload_article permet d'ajouter une nouvelle publication via l'api
  static uploadArticle(
      File imageFiles, String title, String description, String userId) async {
    String url = "https://clo-express.000webhostapp.com/API/index.php";
    var steam =
        new http.ByteStream(DelegatingStream.typed(imageFiles.openRead()));
    var length = await imageFiles.length();
    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);

    var multipartfile = new http.MultipartFile("image", steam, length,
        filename: path.basename(imageFiles.path));
    request.fields['type'] = "4";
    request.fields['title'] = title;
    request.fields['descrip'] = description;
    request.fields['userId'] = userId;
    request.files.add(multipartfile);
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Reussi");
        response.stream.transform(utf8.decoder).listen((v) {
          print(v);
        });
        return true;
      } else {
        print("Echec");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<List<ArticleModel>> getArticles() async {
    List<ArticleModel> pubs = [];
    String type = "5";
    String url = "https://clo-express.000webhostapp.com/API/index.php";
    Map<String, String> body = {"type": type};

    try {
      final response = await http.post(url, body: body);
      for (var pub in jsonDecode(response.body)) {
        pubs.add(ArticleModel.fromJson(pub));
      }
      print(pubs);
      return pubs;
    } on Exception catch (e) {
      return [];
    }
  }
}
