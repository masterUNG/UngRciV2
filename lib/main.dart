import 'package:flutter/material.dart';
import 'package:ungrci/page/authen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      title: 'Ung RCI',
      home: Authen(),
    );
  }
}
