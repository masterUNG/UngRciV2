import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ungrci/models/user_model.dart';
import 'package:ungrci/utility/my_constant.dart';
import 'package:ungrci/utility/my_style.dart';

class EditInfoShop extends StatefulWidget {
  final UserModel userModel;
  EditInfoShop({Key key, this.userModel}) : super(key: key);

  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String dateTimeString, gender, educateString, address, phone, id;
  List<String> educates;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userModel = widget.userModel;
    gender = userModel.gendel;
    educateString = userModel.education;
    address = userModel.address;
    phone = userModel.phone;
    id = userModel.id;

    educates = MyConstant().educates;

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
      appBar: AppBar(
        title: Text('Edit InFomation'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            showDate(),
            addressForm(),
            phoneForm(),
            genderGroup(),
            educationDropdown(),
          ],
        ),
      ),
    );
  }

  Container educationDropdown() => Container(width: 250,
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
            mailRadio(),
            feMaleRadio(),
          ],
        ),
      );

  Row mailRadio() {
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

  Row feMaleRadio() {
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

  Widget addressForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextFormField(
          initialValue: address,
          decoration: MyStyle().myInputDecoration('Address :'),
        ),
      );

  Widget phoneForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextFormField(
          initialValue: phone,
          decoration: MyStyle().myInputDecoration('Phone :'),
        ),
      );

  Widget showDate() => MyStyle().showTextH2('DateTime = $dateTimeString');
}
