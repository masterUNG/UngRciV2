import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungrci/page/authen.dart';

class MyStyle {
  Color mainColor = Colors.pink;
  Color darkColor = Colors.blue.shade800;

  Widget menuSignOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.red.shade800),
          child: ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.white),
            title: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'ออกจาก Account และ ไปที่ Authen',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();

              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Authen(),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
          ),
        ),
      ],
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  InputDecoration myInputDecoration(String string) {
    return InputDecoration(
      labelText: string,
      border: OutlineInputBorder(),
    );
  }

  Text showTextH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  Container showLogo() {
    return Container(
      width: 150,
      child: Image.asset('images/logo.png'),
    );
  }

  MyStyle();
}
