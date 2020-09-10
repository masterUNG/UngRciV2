import 'dart:ffi';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ungrci/utility/my_style.dart';
import 'package:ungrci/utility/normal_dialog.dart';
import 'package:ungrci/widget/detail_barcode.dart';

class ReadBarCode extends StatefulWidget {
  @override
  _ReadBarCodeState createState() => _ReadBarCodeState();
}

class _ReadBarCodeState extends State<ReadBarCode> {
  String barcodeString, itemCode, weightCode, priceCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Bar Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildBarCodeButton(),
          itemCode == null ? SizedBox() : buildTextResult(),
        ],
      ),
    );
  }

  Widget buildTextResult() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBarcode(
                      barcodeString: itemCode,
                    ),
                  ),
                ),
                title: MyStyle().showTextH2('ItemCode = $itemCode'),
                trailing: Icon(
                  Icons.forward,
                  size: 36,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          MyStyle().showTextH2('WeightCode = $weightCode'),
          MyStyle().showTextH2('PriceCode = $priceCode'),
        ],
      );

  Row buildBarCodeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print('You Click Bar code');
            barCodeReader();
          },
          child: Card(
            child: Container(
              width: 150,
              child: Image.asset('images/barcode.png'),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> barCodeReader() async {
    try {
      var result = await BarcodeScanner.scan();
      barcodeString = result.rawContent;
      print('barcodeString ==> $barcodeString');

      if (barcodeString.length == 20) {
        decodeBarCode();
      } else if (barcodeString.length == 22) {
      } else {
        normalDialog(context, 'BarCode ไม่ได้อยู่ใน ฐานข้อมูลของเรา');
      }
    } catch (e) {}
  }

  void decodeBarCode() {
    setState(() {
      itemCode = barcodeString.substring(0, 8);
      // print('itemCode ===>> $itemCode');

      weightCode = barcodeString.substring(8, 14);
      weightCode =
          '${weightCode.substring(0, 3)}.${weightCode.substring(3, 6)}';
      double weightDouble = double.parse(weightCode);
      var myFormat = NumberFormat('##0.000', 'en_US');
      weightCode = myFormat.format(weightDouble);
      // print('weightCode ===>> $weightCode');
      // print('weithtDouble ===>> $weightDouble');

      priceCode = barcodeString.substring(14, 20);
      priceCode = '${priceCode.substring(0, 4)}.${priceCode.substring(4, 6)}';
      double priceDou = double.parse(priceCode);
      print('princtDou ==>> $priceDou');
      var priceFormat = NumberFormat('##0.00', 'en_US');
      priceCode = priceFormat.format(priceDou);
      print('priceCode ==>> $priceCode');
    });
  }
}
