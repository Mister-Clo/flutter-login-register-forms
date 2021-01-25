import 'package:flutter/material.dart';
import 'package:http_requests/home.dart';
import 'package:http_requests/model/userModel.dart';
import 'package:http_requests/pages/login.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  UserModel user;

  getUser() async {
    final data = await UserModel.getUser();
    if (data != null) {
      user = data;
      setState(() {});
    } else {
      user = UserModel();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (user?.id != null)
        return Home();
      else
        return Login();
    }
  }
}
