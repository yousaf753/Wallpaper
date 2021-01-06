import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
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
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () async {
              download() ;
            },
           child: Container(
             margin: EdgeInsets.only(bottom: 50),
             child:
                 persentage =="0%"?
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(
                   Icons.check,
                   color: Colors.white,
                   size: 60,
                   semanticLabel: 'Text to announce in accessibility modes',
                 ),
                 Text('Set Wallpaper',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic),)
               ],
             )
                     :
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Downloading  ',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic),),
                               Text('$persentage',style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),)
    ],
           ),
          ),
        ),
        )
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
