import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:ungrci/utility/my_constant.dart';

class DownloadFile extends StatefulWidget {
  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RaisedButton(
        onPressed: () => processDownload(),
        child: Text('Download File'),
      ),
    );
  }

  Future<Null> processDownload() async {
    String pathDownload = '/sdcard/download';
    String urlDownload = '${MyConstant().domain}/RCI/download/ItemData.txt';

    try {
      FileUtils.mkdir([pathDownload]);
      await Dio()
          .download(urlDownload, '$pathDownload/ItemData2.txt')
          .then((value) {
        print('###### Success Download ########');
      });
    } catch (e) {
      print('Error on ProcessDownload #####===>>> ${e.toString()}');
    }
  }
}
