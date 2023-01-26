import 'dart:convert';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


enum AuthMode { Signup, Login }



final mycolors = [
  Colors.yellowAccent,
  Colors.red,
  Colors.blueAccent,
  Colors.green,
  Colors.purple,
  Colors.teal
];




class WelcomeSCreen extends StatefulWidget {
  const WelcomeSCreen({Key? key}) : super(key: key);

  @override
  State<WelcomeSCreen> createState() => _WelcomeSCreenState();
}

class _WelcomeSCreenState extends State<WelcomeSCreen> with SingleTickerProviderStateMixin  {


  late AnimationController animated_controller;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    animated_controller = AnimationController(vsync: this, duration: const Duration( seconds: 2));
    animated_controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animated_controller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'phoneNumber': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();



  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );


  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }


  void _submit() async {
    final storage = const FlutterSecureStorage();

    var dio = Dio();
    if (!_formKey.currentState!.validate())  {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {

        final data =await dio.post("https://yourrommate.up.railway.app/rest-auth/login/",
            data: json.encode({
              "username": _authData['email'],
              "password": _authData['password'],

            })
        ).then((value) async {
          dio.post("https://yourrommate.up.railway.app/hattoken/",
              data: json.encode({
                "token":value.data.toString()
              })
          );
          await storage.write(key: 'token', value: value.data.toString());
          Navigator.of(context).pushReplacementNamed("home");
        });




      } else {

          final data =await dio.post("https://yourrommate.up.railway.app/rest-auth/registration/",
              data: json.encode({
              "username": _authData['email'],
                "password1": _authData['password'],
                "password2": _authData['password'],
              })
          ).then((value) async {
             dio.post("https://yourrommate.up.railway.app/hattoken/",
              data: json.encode({
                "token":value.data.toString()
              })
            );
             await storage.write(key: 'token', value: value.data.toString());
             Navigator.of(context).pushReplacementNamed("home");
          });





      }


    } catch(err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("الباسورد بتاعك صغير او الايميل مكرر او في مشكله في الانترنت"))
      );
    }
    setState(() {
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgi.jpg')
            )
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: AnimatedTextKit(

                    animatedTexts: [
                      ColorizeAnimatedText(
                          "اهلا بيـــيـك", textStyle: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          ),
                          colors: mycolors
                      ),
                      ColorizeAnimatedText(
                          "لايجاد", textStyle: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          ),
                          colors: mycolors
                      ),

                      ColorizeAnimatedText(
                          "غرفتك او شقتك", textStyle: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          fontFamily:  'Acme'),
                          colors: [
                            Colors.yellowAccent,
                            Colors.red,
                            Colors.blueAccent,
                            Colors.green,
                            Colors.purple,
                            Colors.teal
                          ]
                      ),
                      ColorizeAnimatedText(
                          "بأرخص الاسعار", textStyle: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          ),
                          colors: [
                            Colors.yellowAccent,
                            Colors.red,
                            Colors.blueAccent,
                            Colors.green,
                            Colors.purple,
                            Colors.teal
                          ]
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,


                  ),
                ),


                Column(
                  children: [

                Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8.0,
      child:  Form(

        key: _formKey,
        child: SingleChildScrollView(
            child: Container(
              color: Colors.black87,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15),
                    child:TextFormField(
                      decoration: InputDecoration(labelText: 'الاسم', hintText: 'الاسم بدون مسافات ' ,hintTextDirection: TextDirection.ltr),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid email!';
                        }
                        return null;
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(

                      decoration: InputDecoration(labelText: 'الباسورد', hintText: 'باسورد يكون فيه ارقام وحروف'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value!.length < 5) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                    ),
                  ),
                  if (_authMode == AuthMode.Signup)

                  if (_authMode == AuthMode.Signup)

                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    TextButton(
                      child:
                      Text(_authMode == AuthMode.Login ? 'ادخل' : 'قم بعمل اكونت'),
                      onPressed: _submit,


                    ),
                  TextButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'قم بتسجيل الدخول لاول مره' : ' معاك اكونت ؟ '}  '),
                    onPressed: _switchAuthMode,
                  ),


                ],
              ),
            ),
        ),
      ),

    ),


                  ],
                ),


                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white38
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //
                //
                //       googlefacebook("Facebook", () async{
                //
                //         var dio = Dio();
                //         try {
                //           await dio.post("http://192.168.1.5:8000/rest-auth/facebook/");
                //
                //         }catch(e) {
                //           print(e);
                //         }
                //
                //
                //       }, Image(
                //         image: AssetImage('assets/images/facebook.jpg'),
                //       ), ),
                //
                //
                //
                //     ],
                //   ),
                // )



              ],
            ),
          ),
        ),
      ),

    );
  }
}

class animatedimage extends StatelessWidget {
  const animatedimage({
    Key? key,
    required this.animated_controller,
  }) : super(key: key);

  final AnimationController animated_controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animated_controller.view,
        builder: (context, child){
          return Transform.rotate(angle: animated_controller.value* 2 * pi, child: child,);
        },
        child: Image(image: AssetImage('assets/images/logo.jpg'),
        ));
  }
}

class googlefacebook extends StatelessWidget {


  late String label;
  late Function() press;
  late Widget child;

  googlefacebook(this.label, this.press, this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: press,
        child: Column(
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: child
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}


class YollowButton extends StatelessWidget {

  late double width;
  late String label;
  Function() press;

  YollowButton(this.width, this.label, this.press);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color:Colors.yellow,
        borderRadius: BorderRadius.circular(25),

      ),
      child: MaterialButton(
        onPressed: press,
        child: Text(label),
      ),
    );
  }
}