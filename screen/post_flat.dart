import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/list_city.dart';
import 'package:provider/provider.dart';
import '../provider/flat_database.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';


enum Pet { yes, no }
enum Visitor { yes, no }
enum Smoking { yes, no }
enum Electroc { yes, no }







class UploadProduct extends StatefulWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {



  var uuid = Uuid();
  final formKey = GlobalKey<FormState>();
  ImagePicker _imagepicker = ImagePicker();
  List<XFile?> file = [];
  late  String location;
  late String descr;
  late int num_rooms;
  late int num_bath;
  String email ="";
  int phone_number= 0;
  late double price;
  late String gender;
  late String oppor;
  late String city = items.first;

  Pet? _pets = Pet.no;
  bool? allow_pets = false;

  Smoking? _smoking = Smoking.no;
  bool? allow_smoking = false;

  Visitor? _visitor = Visitor.no;
  bool? allow_visitor = false;

  Electroc? _electroc = Electroc.no;
  bool? allow_electroc = false;

  List<String> flats_images=[];
  String upload_image = "";
  List id_image = [];




  Widget PreviewImage() {
    if(file.isNotEmpty) {
      return InkWell(
        onLongPress: ()=> setState(() {
          file = [];
        }),
        child: ListView.builder(scrollDirection: Axis.horizontal ,itemCount: file.length, itemBuilder: (context, index){
          return Image.file(File(file[index]!.path));
        }),
      );
    }else {
      return  const Center(
        child: Text("دوس علي ايقونة الصور الصفره عشان تختار الصور اللي عايز ترفعها", textAlign: TextAlign.center,),
      );
    }

  }





   Future<void> getImages() async {

     var dio = Dio();
      var formData = FormData();
     for (var img in file) {
       formData.files.addAll([
         MapEntry('files',  await MultipartFile.fromFile(
           img!.path, filename: img!.path.split('/').last
         ) )
       ]);
     }
     final data = await dio.post("https://yourrommate.up.railway.app/imagecreate/",
         data: formData
     );
     id_image = data.data;

   }

  void pickimages() async {
    final images = await _imagepicker.pickMultiImage(
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 95,
    ) ;
    setState(() {
      file = images ;
    });
    getImages();

  }

  void submit() async  {



    if(!formKey.currentState!.validate()){
      return;
    }
    else {
      formKey.currentState!.save();
      if(file.isNotEmpty) {
        try {
          
          final data =  await Provider.of<FlatDatabase>(context, listen: false).postflat(
            context,

              descr,
              oppor,
              gender,
              num_rooms,
              num_bath,
              allow_electroc,
              city,
              price,
              allow_pets,
              allow_visitor,
              allow_smoking,
              phone_number,
              email,
              id_image
          );
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("شقتك نزلت علي الابلكيشن دلوقتي"))
          );
          formKey.currentState!.reset();
          setState(() {
            file = [];
            flats_images = [];
          });
        }catch(e) {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حاجه غلط حصلت في بياناتك")));
        }

      }else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 50),
                content: Text("Please show some images")
            )
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton:Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed:file.isEmpty ?  () {
              pickimages();
            } :
                ()=> setState(() {
              file = [];
              flats_images = [];
            }),
            backgroundColor: Colors.yellow,
            child: file.isEmpty ? Icon(Icons.photo_library, color: Colors.black,) :Icon(Icons.delete_forever, color: Colors.black,) ,),
        ),
        FloatingActionButton(
          onPressed: submit
          , backgroundColor: Colors.yellow,
          child: Icon(Icons.upload, color: Colors.black,),),

      ],) ,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag ,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueGrey.shade100,
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: double.infinity,
                  child: file != null ? PreviewImage()  :  const Center(
                    child: Text("you have not \n \n picked Images yet", textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox(height: 30, ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          onSaved: (value)=> setState(() {
                            price = double.parse(value!);
                          }),
                          validator: (value) {
                            if(value!.isEmpty) {
                              return "من فضلك ادخل السعر";
                            } else if(value.isValidPrice() != true) {
                              return 'not valid price';
                            }
                            return null;
                          },
                          decoration:textFormDecor, keyboardType: TextInputType.numberWithOptions(decimal: true),),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          onSaved: (value)=> setState(() {
                            num_rooms = int.parse(value!) ;
                          }),
                          validator: (value) {
                            if(value!.isEmpty) {
                              return " من فضلك ادخل عدد اوض الشقة ";
                            }else if (value.isValidQuantity() != true) {
                              return ' not valid quality';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,decoration:textFormDecor.copyWith(hintText: 'كم عدد غرف الشقة', labelText: 'عدد الغرف')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          onSaved: (value)=> setState(() {
                            num_bath = int.parse(value!) ;
                          }),
                          validator: (value) {
                            if(value!.isEmpty) {
                              return " من فضلك ادخل عدد الحمامات ";
                            }else if (value.isValidQuantity() != true) {
                              return ' not valid quality';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,decoration:textFormDecor.copyWith(hintText: 'الشقة فيها كام حمام ؟', labelText: 'عدد الحمامات')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),





                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          onSaved: (value)=> setState(() {
                            oppor = value! ;
                          }),
                          validator: (value) {
                            if(value!.isEmpty) {
                              return " من فضلك ادخل اللي عاوز تاجره ";
                            }
                            return null;
                          },
                          decoration:textFormDecor.copyWith(hintText: 'مثال:- سرير-سنجل روم', labelText: 'المطلوب تاجيره')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          onSaved: (value)=> setState(() {
                            gender = value! ;
                          }),
                          validator: (value) {
                            if(value!.isEmpty) {
                              return " من فضلك ادخل الجنس ";
                            }
                            return null;
                          },
                          decoration:textFormDecor.copyWith(hintText: 'مثال:- ولاد-بنات-ميكس', labelText: 'بدور علي ؟')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8),
                  child: Text("اختار المدينة او المحافظة"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 15, top: 1),
                  child: DropdownButton(

                    borderRadius: BorderRadius.circular(25),
                    dropdownColor: Colors.blueGrey,

                    value: city,
                    onChanged: (value) {
                      setState(() {
                        city = value!;
                      });
                    },
                    items: items.map<DropdownMenuItem>((e){
                      return DropdownMenuItem(child: Text(e), value: e, );
                    }).toList()
                    ,
                  ),
                ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("هل الحيوان مسموح بيها ؟"),
            ),


            Column(
                children: <Widget>[
            ListTile(
            title: const Text('نعم'),
            leading: Radio<Pet>(
              value: Pet.yes,
              groupValue: _pets,
              onChanged: (Pet? value) {
                setState(() {
                  _pets = value;
                  allow_pets = true;
                });

              },
            ),
          ),
          ListTile(
            title: const Text('لا'),
            leading: Radio<Pet>(
              value: Pet.no,
              groupValue: _pets,
              onChanged: (Pet? value) {
                setState(() {
                  _pets = value;
                  allow_pets = false;
                });
              },
            ),
          ),
          ]
        ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("هل التدخين مسموح به ؟"),
                ),


                Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('نعم'),
                        leading: Radio<Smoking>(
                          value: Smoking.yes,
                          groupValue: _smoking,
                          onChanged: (Smoking? value) {
                            setState(() {
                              _smoking = value;
                              allow_smoking = true;
                            });

                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('لا'),
                        leading: Radio<Smoking>(
                          value: Smoking.no,
                          groupValue: _smoking,
                          onChanged: (Smoking? value) {
                            setState(() {
                              _smoking = value;
                              allow_smoking = false;
                            });
                          },
                        ),
                      ),
                    ]
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("هل الزيارات مسموح بيها ؟"),
                ),


                Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('نعم'),
                        leading: Radio<Visitor>(
                          value: Visitor.yes,
                          groupValue: _visitor,
                          onChanged: (Visitor? value) {
                            setState(() {
                              _visitor = value;
                              allow_visitor = true;
                            });

                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('لا'),
                        leading: Radio<Visitor>(
                          value: Visitor.no,
                          groupValue: _visitor,
                          onChanged: (Visitor? value) {
                            setState(() {
                              _visitor = value;
                              allow_visitor = false;
                            });
                          },
                        ),
                      ),
                    ]
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("هل السعر شامل الفواتير و الاجهزة الكهربائية ؟"),
                ),


                Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('نعم'),
                        leading: Radio<Electroc>(
                          value: Electroc.yes,
                          groupValue: _electroc,
                          onChanged: (Electroc? value) {
                            setState(() {
                              _electroc = value;
                              allow_electroc = true;
                            });

                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('لا'),
                        leading: Radio<Electroc>(
                          value: Electroc.no,
                          groupValue: _electroc,
                          onChanged: (Electroc? value) {
                            setState(() {
                              _electroc = value;
                              allow_electroc = false;
                            });
                          },
                        ),
                      ),
                    ]
                ),




                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,

                    child: Center(
                      child: Center(
                        child: TextFormField(
                          onSaved: (value)=> setState(() {
                            descr = value!;
                          }),
                          validator: (value) {
                            if(value!.isEmpty) {
                              return "من فضلك دخل وصف الشقة";
                            }
                            return null;
                          },
                          maxLength: 800, maxLines: 5 ,decoration:textFormDecor.copyWith(hintText: 'الوصف', labelText: 'وصف الشقة')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,

                          onSaved: (value)=> setState(() {
                            email = value! ;
                          }),

                          decoration:textFormDecor.copyWith(hintText: 'الايميل للتواصل', labelText: 'الايميل')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (value)=> setState(() {
                            phone_number = int.parse(value!);
                          }),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'لازم تدخل تلفونك للتواصل';
                            }
                          },
                          decoration:textFormDecor.copyWith(hintText: 'الرقم للتواصل', labelText: 'الرقم')
                          ,
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),),
      ),
    );
  }
}


var textFormDecor = InputDecoration(
  labelStyle: TextStyle(color: Colors.purple),
  labelText: 'السعر',
  hintText: 'السعر ',
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10)
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellow, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
);


extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

// formData = FormData.fromMap({
//   'file': await MultipartFile.fromFile(
//       img!.path,
//       filename: img!.path.split('/').last)
// });

