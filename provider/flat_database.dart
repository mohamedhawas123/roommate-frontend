import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../models/flatmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'dart:convert';


class FlatDatabase with ChangeNotifier {

  var uuid = Uuid();
  List<Flat> _flats = [];


  List<Flat> get flats {
    return [..._flats];
  }



  Future<String?> getoken() async {

    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final encodetoken = json.encode(token);
    return encodetoken;

  }

  



  var dio = Dio();


  Future<List<Flat>> getflatsuser(context) async {




    try {

      final response = await dio.get("https://yourrommate.up.railway.app/userflat/");

      List<Flat>loaded_flats = [];
      print(response.data);


      response.data.map((e) {
        print(e);
        loaded_flats.add(Flat(
          vistor: e['vistor'],
          smoking: e['smoking'],
          price: double.parse(e['price']),
          phone: e['phone'],
          pets: e['pets'],
          oppor: e['oppor'],
          number_room: e['num_room'],
          number_bath: e['num_bath'],
          location: e['location'],
          images: [...e['images']],
          id:  e['id'].toString(),
          gender: e['gender'],
          email: e['email'],
          electroc: e['electroc'],
          desciption: e['descr'],
          name: "",
        ));

      }).toList();
      _flats = loaded_flats;

      notifyListeners();



    }catch(e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("مشكلة في اتصال الانترنت")));
    }



    return flats;

  }





  Future<List<Flat>> getflats(context, [my_location, bool filter=false]) async {

    final storage = const FlutterSecureStorage();

    var value =  storage.read(key: 'token');
    value.then((value) => print(value));

    try {
      
      final response = await dio.get("https://yourrommate.up.railway.app/");

      List<Flat>loaded_flats = [];
      print(response.data);


      response.data.map((e) {
        print(e);
        loaded_flats.add(Flat(
          vistor: e['vistor'],
          smoking: e['smoking'],
          price: double.parse(e['price']),
          phone: e['phone'],
          pets: e['pets'],
          oppor: e['oppor'],
          number_room: e['num_room'],
          number_bath: e['num_bath'],
          location: e['location'],
          images: [...e['images']],
          id:  e['id'].toString(),
          gender: e['gender'],
          email: e['email'],
          electroc: e['electroc'],
          desciption: e['descr'],
          name: "",
        ));

      }).toList();
      _flats = loaded_flats;
      _flats = filter? _flats.where((element) => element.location==my_location).toList():_flats ;
      notifyListeners();



    }catch(e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("مشكلة في اتصال الانترنت")));
    }



    return flats;

  }

 Future<void> postflat(
     BuildContext context,

     desciption,
     oppor,gender, num_rooms,
     num_path, electroc,
     location, price,
     pets,vistor,smoking, phone, email, id_image
     ) async {

    _flats.add(Flat(
      desciption: desciption,
      electroc: electroc,
      email: email,
      gender: gender,
      id: uuid.v1(),

      location: location,
      number_bath: num_path,
      number_room: num_rooms,
      oppor: oppor,
      pets: pets,
      phone: phone,
      price: price,
      smoking: smoking,
      vistor: smoking,
      dateTime: DateTime.now()
    ));
  notifyListeners();
  print(gender);
    try {
      String toky = "";
      await getoken().then((value) {

        toky = value!;
        notifyListeners();
      }
      );
      
      var date = DateTime.now();
      final response=  await dio.post('https://yourrommate.up.railway.app/flatcreate/',

          data: json.encode({
            "token": toky,
            "descr" : desciption,
            "date": date.toIso8601String(),
            "oppor": oppor,
            "gender": gender,
            "num_room": num_rooms,
            "num_bath" : num_path,
            "location": location,
            "price": price,
            "pets": pets,
            "vistor": vistor,
            "smoking": smoking,
            "phone": phone,
            "email": email,
            "id_image" :id_image

          })
      );
      print(response);
      
    }catch(e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطا في الانترنت")));
    }
 


 }

 Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    dio.get("https://yourrommate.up.railway.app/logout/");




 }



}


// final filt = data.docs.where((element) => element['location']== city);

// filter ==true ? filt.map((e) {
//   loaded_flats.add(Flat(
//       vistor: e['vistor'],
//       smoking: e['smoking'],
//       price: e['price'],
//       phone: e['phone'],
//       pets: e['pets'],
//       oppor: e['oppor'],
//       number_room: e['num_rooms'],
//       number_bath: e['num_bath'],
//       location: e['location'],
//       images: [...e['images']],
//       id: e['id'],
//       gender: e['gender'],
//       email: e['email'],
//       electroc: e['electroc'],
//       desciption: e['descr'],
//       name: "",
//       dateTime: e['date']
//   ));
// }).toList():