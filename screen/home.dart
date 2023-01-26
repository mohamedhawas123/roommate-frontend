import 'package:flutter/material.dart';
import './flats.dart';
import './post_flat.dart';
import '../widgets/drawer.dart';


class Roommate extends StatefulWidget {
  const Roommate({Key? key}) : super(key: key);

  @override
  State<Roommate> createState() => _RoommateState();
}

class _RoommateState extends State<Roommate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
length: 2,
      child: Scaffold(

        drawer: Drawy(),
        appBar: AppBar(
          title: Text("روميت مصر"),
          backgroundColor: Colors.green,
          elevation: 0,
          bottom: TabBar(
indicatorWeight: 3,
indicatorColor: Colors.blueGrey,
              isScrollable: true,
              tabs: [
            Tab(child: Text("بدور علي شقة"),),
                Tab(child: Text("بدور علي روميت"),)

              ]),


        ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/6.jpg')
          )
        ),
        child: TabBarView(

          children: [
          Flats(),
          UploadProduct()
        ],),
      ),
      ),
    );
  }
}
