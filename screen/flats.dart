import 'package:flutter/material.dart';
import '../widgets/list_flats.dart';
import 'package:provider/provider.dart';
import '../provider/flat_database.dart';
import '../widgets/list_city.dart';


class Flats extends StatefulWidget {
  const Flats({Key? key}) : super(key: key);

  @override
  State<Flats> createState() => _FlatsState();
}

class _FlatsState extends State<Flats> {



  late String city = items.first;
  bool? filter = false;
  @override
  Widget build(BuildContext context) {




    return FutureBuilder(
      future:Provider.of<FlatDatabase>(context, listen:false).getflats(context, city, filter!),
      builder: (context, data) => data.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator(),) :
      Scaffold(

        floatingActionButton: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              filter==true ? FloatingActionButton( child: Icon(Icons.arrow_back_ios_new),onPressed: (){
                setState(() {
                  filter=false;
                });

              }) :Container(height: 3,),
              SizedBox(width: 10,),
              Container(
                height: 80,
                width: 100,
                child: FloatingActionButton(
                  child: Text("بحث بالمدينة", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.indigoAccent),),
                      backgroundColor: Colors.amber,
                    onPressed: (){
                      showModalBottomSheet(


                          context: context, builder: (context){
                        return Container(height: 200,
                          child: Center(
                            child: DropdownButton(

                              borderRadius: BorderRadius.circular(25),
                              dropdownColor: Colors.blueGrey,

                              value: city,
                              onChanged: (value) {
                                setState(() {
                                  city = value!;
                                  filter = true;
                                });

                                Navigator.of(context).pop();
                              },
                              items: items.map<DropdownMenuItem>((e){
                                return DropdownMenuItem(child: Text(e), value: e, );
                              }).toList()
                              ,
                            ),
                          ),
                        );
                      });

                    }),
              ),
            ],
          ),
        ),
backgroundColor: Colors.white10,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),

          child: Container(
            height: 800,
            child: GridView.count(
              childAspectRatio: 1 / 1.4,
                crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 20,
              children: Provider.of<FlatDatabase>(context, listen:false ).flats.map((flat) {
                return Container(

                  child: InkWell(
                    onTap: ()=> Navigator.of(context).pushNamed("flat_detail", arguments: { 'flat_id': flat }),
                    child: Card(

                      elevation: 0,

                      child: Column(
                        children: [
                          Image.network('https://yourrommate.up.railway.app'+flat.images![0].toString(), height: 100, width: double.infinity,),

                          Text(flat.location.toString()),
                          SizedBox(
                            height: 30,
                            child: ListTile(leading: Text("السعر") , trailing: Text("المتاح")),

                          ),
                          SizedBox(
                            height: 40,
                            child: ListTile(leading: Text(flat.price.toString(), style: TextStyle(color: Colors.grey)) , trailing: Text(flat.oppor.toString(), style: TextStyle(color: Colors.grey),)),

                          ),
                          Text(flat.gender.toString())




                        ],
                      ),
                    ),
                  ),
                );
              }).toList()
            ),
          ),
        )
      ),
    );
  }
}


