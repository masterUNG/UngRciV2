import 'dart:convert';

import 'package:charts_flutter/flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungrci/models/sales_model.dart';
import 'package:ungrci/utility/my_constant.dart';
import 'package:ungrci/utility/my_style.dart';

class ShowChart extends StatefulWidget {
  @override
  _ShowChartState createState() => _ShowChartState();
}

class SalesPerProduct {
  final int product;
  final int amount;

  SalesPerProduct(this.product, this.amount);
}

class _ShowChartState extends State<ShowChart> {
  List<SalesPerProduct> listSalesPerProducts = List();
  List<Series> listSeries = List();

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      SalesPerProduct(0, 10),
      SalesPerProduct(20, 100),
      SalesPerProduct(40, 50),
      SalesPerProduct(60, 150),
      SalesPerProduct(80, 70),
      SalesPerProduct(100, 20)
    ];

    var series = [
      Series(seriesColor: Color(r: 3, g: 182, b: 252),
        id: 'idChart1',
        data: listSalesPerProducts,
        domainFn: (SalesPerProduct salesPerProduct, index) =>
            salesPerProduct.product,
        measureFn: (SalesPerProduct salesPerProduct, index) =>
            salesPerProduct.amount,
      ),
      Series(seriesColor: Color(r: 252, g: 3, b: 252),
        id: 'idChart2',
        data: data,
        domainFn: (SalesPerProduct salesPerProduct, index) =>
            salesPerProduct.product,
        measureFn: (SalesPerProduct salesPerProduct, index) =>
            salesPerProduct.amount,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: listSalesPerProducts.length == 0
            ? MyStyle().showProgress()
            : LineChart(
                series,
                animate: true,
              ),
      ),
    );
  }

  Future<Null> readData() async {
    String path = '${MyConstant().domain}/RCI/getAllSales.php';
    await Dio().get(path).then((value) {
      print('value ==>> $value');
      var result = json.decode(value.data);
      for (var json in result) {
        print('json ==>> $json');
        SalesModel model = SalesModel.fromJson(json);
        int x = int.parse(model.xvalue.trim());
        int y = int.parse(model.yvalue.trim());

        setState(() {
          listSalesPerProducts.add(SalesPerProduct(x, y));
        });
      }
    });
  }
}
