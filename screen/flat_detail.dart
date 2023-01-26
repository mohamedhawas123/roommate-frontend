import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class FlatDetail extends StatefulWidget {
  const FlatDetail({Key? key}) : super(key: key);

  @override
  State<FlatDetail> createState() => _FlatDetailState();
}

class _FlatDetailState extends State<FlatDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late final myflat;

  @override
  void didChangeDependencies() {

    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, Object> ;
    final aflat = routeArgs!['flat_id'];
    setState(() {
      myflat = aflat;
    });


    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
          title:Text(myflat!.location)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.7,
            width: double.infinity,
            child: ListView.builder( scrollDirection: Axis.horizontal ,itemCount: myflat!.images.length, itemBuilder: (context, index){
              return Image.network("https://yourrommate.up.railway.app"+myflat!.images[index], );
            })   ,
          ),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(25),
                color: Colors.pink
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text( myflat!.desciption !="" ? myflat!.desciption : "لا يـــوجـــد وصـــف للــــشـــقة",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text( "مسموح بالحيوانات ؟", style: TextStyle(color: Colors.teal),),
                Text("مسموح بالتدخين؟", style: TextStyle(color: Colors.teal),),

                Text("مسموح بالزيارات؟", style: TextStyle(color: Colors.teal),)


              ],
            ),
          ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(myflat!.pets ==false ? "لا ": "نعم"),
                Text(myflat!.vistor ==false ? "لا ": "نعم"),
                Text(myflat!.smoking ==false ? "لا ": "نعم"),


              ],
          ),
           ),

          SizedBox(height: 25,),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("عدد الغرف ؟", style: TextStyle(color: Colors.amber),),
                Text("عدد الحمامات؟", style: TextStyle(color: Colors.amber),),

                Text("السعر شامل الفواتير؟", style: TextStyle(color: Colors.amber),)


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(myflat!.number_room.toString()),
                Text(myflat!.number_bath.toString()),
                Text(myflat!.electroc ==false ? "لا ": "نعم"),




              ],
            ),
          ),


          Padding(
            padding: EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("الايميل ", style: TextStyle(color: Colors.pinkAccent),),

                Text("رقم التلفون", style: TextStyle(color: Colors.pinkAccent),)


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(myflat!.email ==null? "لا يوجد ايميل" : myflat!.email.toString(), style: TextStyle(fontSize: 13),),
                Text(myflat!.phone ==null? "لا يوجد رقم هاتف": myflat!.phone.toString()),




              ],
            ),
          ),




        ],
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// children: [
// Text("هل مسموح بالزيارات ؟", style: TextStyle(fontSize: 20) ,textAlign: TextAlign.end,),
// SizedBox(width: 10,),
//
// Text("لا", style: TextStyle(fontSize: 17),)
// ],
// ),
// ),


