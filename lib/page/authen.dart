import 'package:flutter/material.dart';
import 'package:ungrci/models/user_model.dart';
import 'package:ungrci/page/register.dart';
import 'package:ungrci/utility/my_api.dart';
import 'package:ungrci/utility/my_style.dart';
import 'package:ungrci/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              MyStyle().showTextH1('Ung Rci'),
              userForm(),
              passwordForm(),
              loginButton(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container loginButton() {
    return Container(
      width: 250,
      child: RaisedButton(
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
          } else {
            checkAuthen();
                      }
                    },
                    child: Text('Login'),
                  ),
                );
              }
            
              Container registerButton() {
                return Container(
                  width: 250,
                  child: FlatButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Register(),
                      );
                      Navigator.push(context, route);
                    },
                    child: Text(
                      'New Register',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                );
              }
            
              Widget userForm() => Container(
                    margin: EdgeInsets.only(top: 16),
                    width: 250,
                    child: TextField(
                      onChanged: (value) => user = value.trim(),
                      decoration: MyStyle().myInputDecoration('User :'),
                    ),
                  );
            
              Widget passwordForm() => Container(
                    margin: EdgeInsets.only(top: 16),
                    width: 250,
                    child: TextField(
                      onChanged: (value) => password = value.trim(),
                      decoration: MyStyle().myInputDecoration('Password :'),
                    ),
                  );
            
              Future<Null> checkAuthen()async {
                UserModel model = await  MyAPI().getUserWhereUser(user);
              }
}
