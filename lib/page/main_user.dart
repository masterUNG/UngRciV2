import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungrci/models/user_model.dart';
import 'package:ungrci/utility/my_constant.dart';
import 'package:ungrci/utility/my_style.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  List<UserModel> userModels = List();
  List<Widget> widgets = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readShop();
  }

  Future<Null> readShop() async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereType.php?isAdd=true&Type=Shop';

    Response response = await Dio().get(url);
    // print('res = $response');

    var result = json.decode(response.data);
    // print('resule = $result');

    for (var map in result) {
      UserModel model = UserModel.fromJson(map);
      if (!(model.createDate.isEmpty)) {
        // print('nameShop ==> ${model.name}');
        setState(() {
          userModels.add(model);
          widgets.add(createWidget(model.name));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MyStyle().menuSignOut(context),
      ),
      appBar: AppBar(
        title: Text('Welcome User'),
      ),
      body: userModels.length == 0 ? MyStyle().showProgress() : buildShop(),
    );
  }

  Widget buildShop() => GridView.extent(
        maxCrossAxisExtent: 160,
        children: widgets,
      );

  Widget createWidget(String name) {
    return Card(
          child: Column(
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            child: Image.asset('images/shop.png'),
          ),
          Text(name),
        ],
      ),
    );
  }
}
