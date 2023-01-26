import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/flat_database.dart';
import '../widgets/list_city.dart';


class Flatsuser extends StatefulWidget {
  const Flatsuser({Key? key}) : super(key: key);

  @override
  State<Flatsuser> createState() => _FlatsuserState();
}

class _FlatsuserState extends State<Flatsuser> {



  late String city = items.first;
  bool? filter = false;
  @override
  Widget build(BuildContext context) {




    return FutureBuilder(
      future:Provider.of<FlatDatabase>(context, listen:false).getflatsuser(context),
      builder: (context, data) => data.connectionState == ConnectionState.waiting ?
      Center(child: CircularProgressIndicator(),) :
      Scaffold(
          appBar: AppBar(backgroundColor: Colors.green,),
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


