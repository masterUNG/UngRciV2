import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungrci/models/user_model.dart';
import 'package:ungrci/utility/my_constant.dart';

import 'normal_dialog.dart';

class MyAPI {
  Future<Null> editValueOnMySQl(
      BuildContext context,
      String id,
      String dateTimeString,
      String address,
      String phone,
      String gender,
      String educateString) async {
    String url =
        '${MyConstant().domain}/RCI/editUserWhereIdUng.php?id=$id&isAdd=true&CreateDate=$dateTimeString&Address=$address&Phone=$phone&Gendel=$gender&Education=$educateString';

    print('url Authen ==> $url');
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'Please Try Again');
      }
    });
  }

  Future<UserModel> getUserWhereUser(String user) async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereUserUng.php?isAdd=true&User=$user';

    print('url getUserWhereUser ==>> $url');

    Response response = await Dio().get(url);
    print('res = $response');
    if (response.toString() == 'null') {
      return null;
    } else {
      var result = json.decode(response.data);
      for (var map in result) {
        UserModel model = UserModel.fromJson(map);
        return model;
      }
    }
  }

  MyAPI();
}
