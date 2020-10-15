import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungrci/utility/my_constant.dart';
import 'package:ungrci/utility/my_style.dart';
import 'package:ungrci/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> types = ['User', 'Shop'];
  String type, name, user, password;

  List<String> laws = MyConstant().laws;

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

  Widget nameForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: MyStyle().myInputDecoration('Name :'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyStyle().showLogo(),
              nameForm(),
              dropDownType(),
              userForm(),
              passwordForm(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (name == null ||
            name.isEmpty ||
            user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Please Fill Every Blank');
        } else if (type == null) {
          normalDialog(context, 'โปรดเลือกชนิดของ สมาชิก');
        } else {
          checkUserThread();
          // registerThread();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Container dropDownType() => Container(
        child: DropdownButton(
          items: types
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          hint: Text('Choose Type'),
          value: type,
          onChanged: (value) {
            setState(() {
              type = value;
            });
          },
        ),
      );

  Future<Null> registerThread() async {
    DateTime dateTime = DateTime.now();
    String dateString = dateTime.toString();
    print('dateString = $dateString');

    String urlAPI =
        '${MyConstant().domain}/RCI/addUserUng.php?isAdd=true&Name=$name&User=$user&Password=$password&CreateDate=$dateString&Type=$type';
    Response response = await Dio().get(urlAPI);
    if (response.toString() == 'true') {
      Navigator.pop(context);
    } else {
      normalDialog(context, 'กรุณาลองใหม่ อีกครั้ง');
    }
  }

  Future<Null> checkUserThread() async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereUserUng.php?isAdd=true&User=$user';
    Response response = await Dio().get(url);
    if (response.toString() == 'null') {
      confirmRegister();
      // registerThread();
    } else {
      normalDialog(
          context, '$user มีคนอืี่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่ คะ');
    }
  }

  Future<Null> confirmRegister() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Container(
            width: 48,
            child: Image.asset('images/logo.png'),
          ),
          title: MyStyle().showTextH2('เงื่อนไข การใช้บริการ'),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(laws[0]),
          ),Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(laws[1]),
          ),Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(laws[2]),
          ),Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(laws[3]),
          ),Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(laws[4]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlineButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  registerThread();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                label: Text('ยอมรับ'),
              ),
              OutlineButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                label: Text('ไม่ยอมรับ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
