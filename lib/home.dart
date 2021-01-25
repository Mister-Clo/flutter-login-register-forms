import 'package:flutter/material.dart';
import 'package:http_requests/homeDrawer.dart';
import 'package:http_requests/model/userModel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Homedrawer(),
      body: Container(
        child: Center(
          child: Text('${UserModel.currentuser.email}'),
        ),
      ),
    );
  }
}
