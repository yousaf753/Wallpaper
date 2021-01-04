import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //key = fObCQEHZ7xaKFpv1rgXDCma1xoiICo3D1x2ZnR73bqI
  List data;
  String _localfile;
@override
void initState(){
  super.initState();
  String type ="nature";
  fetchImage(type);
  _getpermission();
}
Future <String> fetchImage(String type) async{
  var fetchdata = await http.get('https://api.unsplash.com/search/photos?'
      'per_page=30&client_id=fObCQEHZ7xaKFpv1rgXDCma1xoiICo3D1x2ZnR73bqI&query=$type'
        );
     var jsondata = json.decode(fetchdata.body);
     setState(() {
   data = jsondata['results'];
     });
     return 'success';
}
_getpermission() async{
  if(PermissionStatus.granted != null)
    {
      final Map<Permission, PermissionStatus> statuses = await [ Permission.storage,].request();
    }

  }
_onTap(context,values)
{
  return AlertDialog(
    title: Text(' Set as Wallpaper'),
    actions: [
      FlatButton(onPressed: (){
        Navigator.pop(context);
      },
          child:Text('NO')),
      FlatButton(onPressed: () async {
       Dio dio = Dio();
       final Directory appdirectory = await getExternalStorageDirectory();
       final Directory directory = await Directory(appdirectory.path+'wallpaper').create(recursive: true);
       final String dir = directory.path;
       final String localfile = '$dir/myimage.jpeg';
       try {
         await dio.download(values, localfile);
         setState(() {
           _localfile = localfile;
         });
         Wallpaperplugin.setAutoWallpaper(localFile: _localfile);
       } on PlatformException catch (e) {
         print(e);
       }
       Navigator.pop(context);
      },
        child: Text('Yes'),
        
      )
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wallpaper App",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Wallpaper App'),
            centerTitle: true,
          ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context,index){
            return Stack(
              children: [
              InkWell(
                onTap: (){
                  showDialog(context: context,
                  builder:(context) => _onTap(context,
                 data[index]['links']['download'] ));
                },
                child:Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.network(data[index]['urls']['small'],
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.maxFinite,
                  ),
                )
                ,
              ),
              ],
            );
          },
        ),
      ),
    );
  }
}


