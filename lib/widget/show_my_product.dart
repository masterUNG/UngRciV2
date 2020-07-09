import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungrci/page/add_product_shop.dart';
import 'package:ungrci/utility/my_constant.dart';
import 'package:ungrci/utility/my_style.dart';

class ShowMyProduct extends StatefulWidget {
  @override
  _ShowMyProductState createState() => _ShowMyProductState();
}

class _ShowMyProductState extends State<ShowMyProduct> {
  String idShop;
  bool waitStatus = true; // true ==> Load Data
  bool dataStatus = true; //true ==> no Menu

  @override
  void initState() {
    super.initState();
    findShopAndMenu();
  }

  Future<Null> findShopAndMenu() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idShop = preferences.getString('id');

    // idShop = '1';

    String url =
        '${MyConstant().domain}/RCI/getProductWhereIdShopUng.php?isAdd=true&IdShop=$idShop';
    await Dio().get(url).then((value) {
      setState(() {
        waitStatus = false;
      });

      if (value.toString() != 'null') {
        setState(() {
          dataStatus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AddProductShop(),
          );
          Navigator.push(context, route).then((value) => null);
        },
        child: Icon(Icons.restaurant_menu),
      ),
      body: waitStatus
          ? MyStyle().showProgress()
          : dataStatus
              ? Center(child: MyStyle().showTextH1('ไม่มี Product กรุณา Add Product'))
              : Text('Have Product'),
    );
  }
}
