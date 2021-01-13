import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'set wallpaper.dart' as wallpaper;
class Wallpaper extends StatefulWidget{
   final   String name;
Wallpaper( {@required this.name});
  @override
  _WallpaperState createState() => _WallpaperState();
}
  @override
  State<StatefulWidget> createState( ) {
    // TODO: implement createState
    throw UnimplementedError();
  }

class _WallpaperState extends State<Wallpaper> {
  //key = fObCQEHZ7xaKFpv1rgXDCma1xoiICo3D1x2ZnR73bqI
  List data=null;
  @override
  Widget build(BuildContext context,) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = (size.width / 2);
    fetchImage(widget.name);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: data==null? Center(
                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading ',style: TextStyle(fontSize: 50,color: Colors.red),),
                    SizedBox(
                      child:CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        strokeWidth: 10,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                      height: 50.0,
                      width: 50.0,
                    ),
                  ],
                )
              )
            :
        GridView.builder(
          itemCount: data == null ? 0 : data.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: (itemWidth / itemHeight)
                 ),
          itemBuilder: ( context,  index) {
            return Stack(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => wallpaper.setwallpaper( values:  data[index]['links']['download'], image:data[index]['urls']['small'] ,)));
                  },
                  child:Container(
                    height: 1500,
                    width: 500,
                    padding: EdgeInsets.all(2),
                    child: Image.network(data[index]['urls']['small'],
                      fit: BoxFit.cover,
                    ),
                  )
                  ,
                ),
              ],
            );
          },
        )
    );
  }
  fetchImage(String name) async{
      var fetchdata = await http.get('https://api.unsplash.com/search/photos?'
        'per_page=30&client_id=fObCQEHZ7xaKFpv1rgXDCma1xoiICo3D1x2ZnR73bqI&query=$name'
    );
    var jsondata = json.decode(fetchdata.body);
    setState(() {
      data = jsondata['results'];
    });
    return 'success';
  }
}


