import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungrci/models/banner_model.dart';
import 'package:ungrci/models/product_model.dart';
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
  int i = 0;

  List<BannerModel> bannerModels = List();
  List<Widget> bannerWidgets = List();

  List<ProductModel> productModels = List();
  int amountListProduct = 5;
  ScrollController scrollController = ScrollController();

  List<Widget> naviWidgets;
  int naviIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readShop();
    readBanner();
    readProduct();
    findNameLogin();
    durationTime();
    setupScorllController();

    // naviWidgets.add(buildShop());
    // naviWidgets.add(ShowCart());
    // naviWidgets.add(ShowLocation());
  }

  void setupScorllController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('At The End Screen');
      }
    });
  }

  Future<Null> durationTime() async {
    Duration duration = Duration(seconds: 2);
    await Timer(duration, () {
      setState(() {
        currentWidget = buildShop();
        print('ok 15 sec Success');
      });
    });
  }

  Future<Null> readProduct() async {
    String path = '${MyConstant().domain}/RCI/getAllProduct.php';
    await Dio().get(path).then((value) {
      for (var json in json.decode(value.data)) {
        ProductModel model = ProductModel.fromJson(json);
        setState(() {
          productModels.add(model);
        });
      }
    });
  }

  Future<Null> readBanner() async {
    String path = '${MyConstant().domain}/RCI/getAllBanner.php';
    await Dio().get(path).then((value) {
      // print('value ==> $value');
      var result = json.decode(value.data);
      for (var json in result) {
        BannerModel model = BannerModel.fromJson(json);
        setState(() {
          bannerModels.add(model);
          bannerWidgets.add(createBanner(model));
        });
      }
    });
  }

  Widget createBanner(BannerModel model) {
    print('url ==>> ${model.url}');
    return Container(
      height: 200,
      child: Column(
        children: [
          Image.network('${MyConstant().domain}${model.url}'),
          // MyStyle().showTextH2(model.name),
        ],
      ),
    );
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
        i++;
      }
    }
    if (i >= widgets.length) {
      i = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        actions: <Widget>[MyStyle().showChart(context)],
        title: Text('Welcome User'),
      ),
      // body: currentWidget,
      body: (userModels.length == 0) ||
              (bannerWidgets.length == 0) ||
              (productModels.length == 0)
          ? MyStyle().showProgress()
          : currentWidget,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
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

  Widget buildShop() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildBanner(),
            buildTitle('Shop :'),
            buildGridView(),
            MyStyle().mySizeBox(),
            buildListViewHorizontal(),
            buildTitle('Product :'),
            buildListView(),
            buildRaisedButton(),
          ],
        ),
      ),
    );
  }

  Widget buildListViewHorizontal() {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: bannerModels.length,
        itemBuilder: (context, index) => Container(
          height: 200,
          child:
              Image.network('${MyConstant().domain}${bannerModels[index].url}'),
        ),
      ),
    );
  }

  Widget buildRaisedButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () {
            amountListProduct += 5;
            if (amountListProduct < productModels.length) {
              durationTime();
            } else {
              amountListProduct -= 5;
              durationTime();
            }
          },
          child: Text('Load More'),
        ),
      );

  ListView buildListView() => ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: amountListProduct,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: MyStyle().showTextH2(productModels[index].name),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5 - 16,
              child: Image.network(
                  '${MyConstant().domain}${productModels[index].pathImage}'),
            ),
          ],
        ),
      );

  Row buildTitle(String string) {
    return Row(
      children: [
        MyStyle().showTextH1(string),
      ],
    );
  }

  GridView buildGridView() {
    return GridView.extent(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      maxCrossAxisExtent: 160,
      children: widgets,
    );
  }

  Widget buildBanner() => CarouselSlider(
        items: bannerWidgets,
        options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 2),
            enlargeCenterPage: true),
      );

  Widget createWidget(String name, int index) {
    List<String> nameIcons = MyConstant().nameIcons;
    // int i = Random().nextInt(20);
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Image.asset('images/${nameIcons[i]}'),
              ),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
