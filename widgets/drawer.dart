import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roommate/provider/flat_database.dart';
import '../screen/welcomescreen.dart';


class Drawy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [

            AppBar(title: Text("اهــلا بيـــك  😀	"), backgroundColor: Colors.blueGrey, automaticallyImplyLeading: false, ),


            Divider(),

            ListTile(
              leading: Icon(Icons.account_balance_outlined),
              title: Text("شققي"),
              onTap: () =>{
                Navigator.of(context).pushNamed("flatsuser")

              },

            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("تسجيل خروج"),
              onTap: () async => {
                await Provider.of<FlatDatabase>(context, listen: false).logout(),
                Navigator.of(context).pushReplacement( MaterialPageRoute(
                    builder: (context)=> Directionality(textDirection: TextDirection.rtl, child: WelcomeSCreen(),)) )
              },


            ),

            Divider(),










          ],
        ),
      ),
    );
  }
}
