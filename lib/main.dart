import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'categorylist.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState(){
    super.initState();
    String type ="nature";
    _getpermission();
  }
  _getpermission() async{
    if(PermissionStatus.granted != null)
    {
      final Map<Permission, PermissionStatus> statuses = await [ Permission.storage,].request();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AnimatedSplashScreen(
          duration: 3000,
          splash:Container(
            height: double.infinity,
             width:double.infinity,
            child: Image.asset('image/splash.jpg',
              fit: BoxFit.contain,),
          ),
          nextScreen: CategoryList(),
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Colors.blue
      )
    );
  }
}
