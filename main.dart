import 'package:flutter/material.dart';
import 'package:roommate/provider/flat_database.dart';
import './screen/home.dart';
import './screen/flat_detail.dart';
import './screen/post_flat.dart';
import 'package:provider/provider.dart';
import './screen/welcomescreen.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import './screen/userflats.dart';
import 'package:dio/dio.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  var token = "";


  @override
  void initState() {
    final storage = const FlutterSecureStorage();
    var value =  storage.read(key: 'token');

    value.then((value) {
      setState(() {
        token = value!;
      });
    });
    print(token);

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => FlatDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Tajawal'
        ),

        home:Roommate(),
        // token == null || token == "" ?  Directionality(
        //   textDirection: TextDirection.rtl,
        //     child: WelcomeSCreen()
        // ) : Directionality(
        //     textDirection: TextDirection.rtl,
        //     child: Roommate()
        // ) ,
        routes: {
          "flatsuser": (context) =>Directionality(textDirection: TextDirection.rtl,child: Flatsuser()),
          "home": (context) =>Directionality(textDirection: TextDirection.rtl,child: Roommate()),
          "flat_detail": (context)=> Directionality(textDirection: TextDirection.rtl,child: FlatDetail()),
          "post_flat" : (context) => Directionality(textDirection: TextDirection.rtl, child: UploadProduct()),
          "welcome_scree": (context)=> WelcomeSCreen()
        },
      ),
    );
  }
}

