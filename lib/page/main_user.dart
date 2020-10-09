import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungrci/models/user_model.dart';
import 'package:ungrci/page/show_cart.dart';
import 'package:ungrci/page/show_menu_shop.dart';
import 'package:ungrci/utility/my_constant.dart';
import 'package:ungrci/utility/my_style.dart';
import 'package:ungrci/widget/download_file.dart';
import 'package:ungrci/widget/generate_qrcode.dart';
import 'package:ungrci/widget/read_bar_code.dart';
import 'package:ungrci/widget/show_chart.dart';
import 'package:ungrci/widget/show_location.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  List<UserModel> userModels = List();
  List<Widget> widgets = List();
  String nameLogin;
  Widget currentWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readShop();
    findNameLogin();
    currentWidget = buildShop();
  }

  Future<Null> findNameLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    nameLogin = preferences.getString('Name');
  }

  Future<Null> readShop() async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereType.php?isAdd=true&Type=Shop';

    Response response = await Dio().get(url);
    // print('res = $response');

    var result = json.decode(response.data);
    // print('resule = $result');
    int index = 0;
    for (var map in result) {
      UserModel model = UserModel.fromJson(map);
      if (!(model.createDate.isEmpty)) {
        // print('nameShop ==> ${model.name}');
        setState(() {
          userModels.add(model);
          widgets.add(createWidget(model.name, index));
        });
        index++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                showHead(),
                buildShowShop(),
                buildShowChart(),
                buildShowLocaion(),
                buildShowDownloadFile(),
                buildShowGenQRcode(),
                buildCart(),
                buildReadBarCode(),
              ],
            ),
            MyStyle().menuSignOut(context),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[MyStyle().showChart(context)],
        title: Text('Welcome User'),
      ),
      // body: currentWidget,
      body: userModels.length == 0 ? MyStyle().showProgress() : currentWidget,
    );
  }

  ListTile buildShowShop() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = buildShop();
          });
        },
        leading: Icon(
          Icons.home,
          size: 36,
          color: Colors.orange,
        ),
        title: Text('แสดง ร้านค้า'),
        subtitle: Text('Shop All Shop'),
      );

  ListTile buildShowChart() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowChart();
          });
        },
        leading: Icon(
          Icons.graphic_eq,
          size: 36,
          color: Colors.blue,
        ),
        title: Text('แสดงกราฟ'),
        subtitle: Text('Demo Show Chart'),
      );

  ListTile buildShowLocaion() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowLocation();
          });
        },
        leading: Icon(
          Icons.map,
          size: 36,
          color: Colors.brown,
        ),
        title: Text('แสดงพิกัด'),
        subtitle: Text('Show All User Location'),
      );

  ListTile buildShowDownloadFile() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = DownloadFile();
          });
        },
        leading: Icon(
          Icons.cloud_download,
          size: 36,
          color: Colors.pink,
        ),
        title: Text('Download File'),
        subtitle: Text('Show All Flie Download'),
      );

  ListTile buildShowGenQRcode() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = GenerateQRcode();
          });
        },
        leading: Icon(
          Icons.crop_landscape,
          size: 36,
          color: Colors.orange.shade800,
        ),
        title: Text('Generate QR code'),
        subtitle: Text('สร้าง QR code'),
      );

  ListTile buildCart() => ListTile(
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => ShowCart(),
          );
          Navigator.push(context, route);
        },
        leading: Icon(
          Icons.add_shopping_cart,
          size: 36,
          color: Colors.pink,
        ),
        title: Text('ตะกร้า ขอบฉัน'),
        subtitle: Text('แสดงสินค้าที่เราจะ Order'),
      );

  ListTile buildReadBarCode() => ListTile(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReadBarCode(),
            ),
          );
        },
        leading: Icon(
          Icons.android,
          size: 36,
          color: Colors.green,
        ),
        title: Text('Read Bar Code'),
        subtitle: Text('อ่าน Bar Code'),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: Text(nameLogin == null ? 'Name ?' : nameLogin),
      accountEmail: Text('Login'),
    );
  }

  Widget buildShop() => GridView.extent(
        maxCrossAxisExtent: 160,
        children: widgets,
      );

  Widget createWidget(String name, int index) {
    return GestureDetector(
      onTap: () {
        print('You Click index = $index');
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowMenuShop(
            userModel: userModels[index],
          ),
        );
        Navigator.push(context, route);
      },
      child: Card(
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
      ),
    );
  }
}
