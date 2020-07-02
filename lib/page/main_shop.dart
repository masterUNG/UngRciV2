import 'package:flutter/material.dart';
import 'package:ungrci/widget/show_info_shop.dart';
import 'package:ungrci/widget/show_my_order_shop.dart';
import 'package:ungrci/widget/show_my_product.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  Widget currentWidget = ShowMyOrderShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('Wellcome Shop'),
      ),
      body: currentWidget,
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(accountName: null, accountEmail: null),
          menuMyOrder(),
          menuMyProduct(),
          menuMyInformation(),
        ],
      ),
    );
  }

  ListTile menuMyOrder() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show My Order'),
        subtitle: Text('ดูรายการสั่งของ'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowMyOrderShop();
          });
        },
      );

  ListTile menuMyProduct() => ListTile(
        leading: Icon(Icons.looks_two),
        title: Text('Show My Product'),
        subtitle: Text('ดูรายการสินค้า'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowMyProduct();
          });
        },
      );

  ListTile menuMyInformation() => ListTile(
        leading: Icon(Icons.looks_3),
        title: Text('Show My Informaion'),
        subtitle: Text('ดูรายละเอียดร้าน'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowInfoShop();
          });
        },
      );
}
