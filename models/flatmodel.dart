import 'package:flutter/material.dart';


class Flat {

   String? id = "";
   String? name = "";
   String? desciption = "";
   List<dynamic>? images = [];

   String? oppor = "";
   String? gender = "male";
   int? number_room = 0;
   int? number_bath = 0;
   bool? electroc = false;
   String? location ="";
   double? price = 1.0;
   bool? pets = false;
   bool? vistor = false;
   bool? smoking = false;
   int? phone = 0;
   String? email = "";
   DateTime? dateTime;




  Flat({
    this.id,
    this.price,
    this.name,
    this.desciption,
    this.gender, this.images,
     this.location,
    this.number_room, this.pets,
    this.oppor,
    this.smoking, this.vistor, this.electroc, this.number_bath, this.phone, this.email, this.dateTime });


}


