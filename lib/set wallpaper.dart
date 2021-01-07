import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wallpaperplugin/wallpaperplugin.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
class setwallpaper extends StatefulWidget {
  String image;
  dynamic values;
  setwallpaper(
  {
    @required this.image,
    @required this.values,
    }
      );
  @required
  _setwallpaperState createState() => _setwallpaperState();
}

class _setwallpaperState extends State<setwallpaper> {
  String _localfile;
  String persentage="0%";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.maxFinite,
            child: Image.network(widget.image,
              fit: BoxFit.fill,),
          ),
            Align(
              alignment: Alignment.center,
              child: persentage !="0%"?
                  Text('Downloading  $persentage',style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic),):
                  Container(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,

                ),
                padding: EdgeInsets.all(10),
                height: 90,
                width: 90,
                margin: EdgeInsets.only(right: 30,bottom: 50),
                child: IconButton(icon: Icon(Icons.check,size: 50,color: Colors.white70,),
                    onPressed: (){
                      download();
                    }),
              ),
            ),
        ],

      ),
    );
  }
  Future<void> download()
  async {
    Dio dio = Dio();
    final Directory appdirectory = await getExternalStorageDirectory();
    final Directory directory = await Directory(appdirectory.path+'wallpaper').create(recursive: true);
    final String dir = directory.path;
    final String localfile = '$dir/myimage.jpeg';
    await dio.download(widget.values, localfile,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            String downloadingPer =
            ((received / total * 100).toStringAsFixed(0) + "%");
            setState(() {
              persentage = downloadingPer;
              return _localfile = localfile;
            });
          }}
    );
    Wallpaperplugin.setAutoWallpaper(localFile: _localfile);
    Navigator.pop(context);
  }
}
