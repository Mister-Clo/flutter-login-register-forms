import 'package:flutter/material.dart';
import 'package:http_requests/model/userModel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('${UserModel.currentuser.email}'),
        ),
      ),
    );
  }
}
