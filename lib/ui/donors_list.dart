import 'package:grazac_blood_line_app/ui/base_screen.dart';
import 'package:flutter/material.dart';

class DonorsList extends StatefulWidget {
  @override
  DonorsListState createState() => DonorsListState();
}

class DonorsListState extends State<DonorsList> {
  bool index = true;
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff44130f),
      key: _scaffoldkey,
      body: BaseScreen(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(),
        )),
      ),
    );
  }
}
