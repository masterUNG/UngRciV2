import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ungrci/utility/my_style.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  String dateTimeString, gender, educateString;
  List<String> educates = [
    'ต่ำกว่า ป.6',
    'มัธยมต้น',
    'มัธยมปลาย',
    'ปริญาตรี',
    'ปริญาโท',
    'ปริญาเอก'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findCurrentTime();
  }

  Future<Null> findCurrentTime() async {
    DateTime dateTime = DateTime.now();
    setState(() {
      dateTimeString = DateFormat('dd/MMMM/yyyy').format(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: null),
      appBar: AppBar(
        title: Text('เพิ่มข้อมูล ร้านค้า'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            titleDate(),
            showDate(),
            addressForm(),
            phoneForm(),
            genderGroup(),
            educateGroup(),
          ],
        ),
      ),
    );
  }

  Container educateGroup() => Container(
        child: DropdownButton<String>(
          value: educateString,
          items: educates
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          hint: Text('Please Choose Education'),
          onChanged: (value) {
            setState(() {
              educateString = value;
            });
          },
        ),
      );

  Container genderGroup() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            maleRadio(),
            femaleRadio(),
          ],
        ),
      );

  Row maleRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'Male',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
        Text('ชาย'),
      ],
    );
  }

  Row femaleRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'Female',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
        Text('หญิง'),
      ],
    );
  }

  Row showDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyStyle().showTextH1(dateTimeString == null ? '' : dateTimeString),
      ],
    );
  }

  Widget titleDate() => MyStyle().showTextH2('วันเวลาที่ บันทึก');

  Widget addressForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          decoration: MyStyle().myInputDecoration('ที่อยู่ :'),
        ),
      );

  Widget phoneForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          keyboardType: TextInputType.phone,
          decoration: MyStyle().myInputDecoration('เบอร์โทรศัพย์ :'),
        ),
      );
}
