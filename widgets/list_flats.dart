// import 'package:flutter/material.dart';
// import '../models/flatmodel.dart';
//
//
// List<Flat> flats = [
//   Flat(
//     phone: 01221164568,
//     email: "seifbond77@gmail.com",
//     pets: true,
//     electroc: true,
//     number_bath: 2,
//     number_room: 3,
//     desciption: "متاح غرفه دبل وغرفه سينجل بنات موظفات فقط بمدينه نصر  منطقه وعماره راقيه جدا جدا وامان الشقه بباب حديد ومتجدده بالكامل والعفش كله جديد حتي فرش السراير اهم حاجه الاحترام والنظافه جدا جداممنوع الوسطاء والسمسره نهائي..",
//     vistor: true,
//     smoking: true,
//     id: "1",
//     gender: "ولاد",
//     oppor: "سرير",
//     price: 2000,
//     location: "شيراتون",
//
//
//       images: [
//         "https://www.wasetegypt.com/wp-content/uploads/2020/01/16-9.jpg",
//         "https://www.semsarmasr.com/media/238/realestate_%D8%B4%D9%82%D8%A9-%D9%84%D9%84%D8%A8%D9%8A%D8%B9-%D8%B3%D9%88%D8%A8%D8%B1-%D9%84%D9%88%D9%83%D8%B3-%D8%B9%D9%84%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D8%A7%D8%AD-%D8%A7%D9%84%D8%AA%D8%AC%D9%85%D8%B9-%D8%A7%D9%84%D8%AE%D8%A7%D9%85%D8%B3-260-%D9%85%D8%AA%D8%B1-%D9%86%D8%B1%D8%AC%D8%B3-%D8%B9%D9%85%D8%A7%D8%B1%D8%A7%D8%AA-%D8%A7%D9%84%D9%82%D8%A7%D9%87%D8%B1%D8%A9-%D8%A7%D9%84%D8%AC%D8%AF%D9%8A%D8%AF%D8%A9120190810104437.jpg",
//         "https://static.standard.co.uk/2022/10/17/13/York%20Street%20346-008.jpg?width=968&auto=webp&quality=50&crop=968%3A645%2Csmart"
//       ]
//   ),
//   Flat(
//       email: "moh@gmail.com",
//       pets: false,
//       electroc: false,
//       number_bath: 2,
//       number_room: 3,
//       desciption: "A Cozy bedroom in an apartment downtown,MoniraOnly 2 minutes walking to Saad Zaghloul metro station ,5 minutes to Tahrir square directly on Kasr El Ainy street ..close to supermarkets and all facilities.The place has a wifi, tv, water heater ,water filter and the room has an air conditionerYou would be sharing the apartment with two sweet girls.Rent is only 2500 ,insurance is the same ,plus 1000 non refundable broker fees. U would be ",
//       vistor: true,
//       smoking: true,
//     id: "2",
//       gender: "بنات",
//       oppor: "اوضه",
//       price: 1500,
//       location: "مدينة نصر",
//       images: ["https://dailyenglish.ir/wp-content/uploads/2022/05/flat-apartment.jpg"]
//   ),
//
//   Flat(
//       pets: true,
//       electroc: true,
//       number_bath: 2,
//       number_room: 3,
//       desciption: "شقه للايجار  زهراء المعادي الشطر التاني مفروشه بالكامل دور الاول مرتفع ٢نوم ١حمام رسبشن قطعتين للتواصل والاستفسار ☎️٠١١١٢٢٣٢٥٢٤",
//       vistor: true,
//       smoking: true,
//     id: "3",
//       gender: "ميكس",
//       oppor: "اوضة",
//       price: 3000,
//       location: "المعادي",
//       images: ["https://static.standard.co.uk/2022/10/17/13/York%20Street%20346-008.jpg?width=968&auto=webp&quality=50&crop=968%3A645%2Csmart"]
//   ),
//
//
//   Flat(
//       pets: true,
//       electroc: true,
//       number_bath: 1,
//       number_room: 3,
//       desciption: "",
//       vistor: true,
//       smoking: true,
//     id: "4",
//       gender: "بنات",
//       oppor: "سرير",
//       price: 1000,
//       location: "الزهراء",
//       images: ["https://realestateeg.com/wp-content/uploads/2015/10/1-%D8%B4%D9%82%D9%82-%D9%84%D9%84%D8%A8%D9%8A%D8%B9-%D8%A8%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-%D8%B4%D9%82%D9%82-%D9%84%D9%84%D8%A8%D9%8A%D8%B9-%D9%81%D9%89-%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-%D8%B4%D9%82%D8%A9-%D9%84%D9%84%D8%A8%D9%8A%D8%B9-%D8%A8%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-%D8%B4%D9%82%D9%82-%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-%D8%B4%D9%82%D9%82-%D8%AA%D9%85%D9%84%D9%8A%D9%83-%D8%A8%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-%D8%B4%D9%82%D9%82-%D8%A8%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-%D8%B4%D9%82%D8%A9-%D9%84%D9%84%D8%A8%D9%8A%D8%B9-%D9%85%D8%AF%D9%8A%D9%86%D8%A9-%D9%86%D8%B5%D8%B1-2.jpg"]
//
//   ),
//
//   Flat(
//       pets: true,
//       electroc: true,
//       number_bath: 2,
//       number_room: 3,
//       desciption: "",
//       vistor: true,
//       smoking: true,
//     id: "5",
//       gender: "بنات و ولاد",
//       oppor: "اوضة",
//       price: 1000,
//       location: "التجمع",
//     images: ["https://realestateeg.com/wp-content/uploads/2015/01/-%D9%84%D9%84%D8%A8%D9%8A%D8%B9-%D8%A8%D8%A7%D9%84%D8%AA%D8%AC%D9%85%D8%B9-%D8%A7%D9%84%D8%AE%D8%A7%D9%85%D8%B3-%D8%B4%D9%82%D8%A9-%D8%A8%D8%A7%D9%84%D8%AA%D8%AC%D9%85%D8%B9-%D8%B4%D9%82%D9%82-%D8%A7%D9%84%D8%AA%D8%AC%D9%85%D8%B9-%D8%A7%D9%84%D8%AE%D8%A7%D9%85%D8%B3-%D8%B4%D9%82%D9%82-%D8%A7%D9%84%D8%AA%D8%AC%D9%85%D8%B9-11.jpg"]
//
//   ),
//
//
// ];
