
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:grazac_blood_line_app/resources/services.dart';
import 'package:grazac_blood_line_app/ui/donors_list.dart';
import 'package:grazac_blood_line_app/ui/add_blood_sample.dart';
import 'package:grazac_blood_line_app/ui/add_blood_sample.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  bool isLoggedIn = false;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  showErrorDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: const Text('Add blood sample to continue!',
                  style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const SignUp()));
                    }),
              ],
              title: const Text(
                'Oops',
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
        });
  }

  @override
  void initState() {
  super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: const Text(
          'BloodLine',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            // This is our main page
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Colors.green.shade500,
                  child: InkWell(
                    onTap: () async {
                      var getList = await BloodSampleServices.getUserModel();
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>   DonorsList(donors: getList.item1!,)));
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white, width: 5.0)),
                        padding: const EdgeInsets.all(20.0),
                        child: const Text('Need',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 3),
              Expanded(
                child: Material(
                  color: Colors.redAccent.shade400,
                  child: InkWell(
                    onTap: () async {
                      var getList = await BloodSampleServices.getUserModel();
                    //  print(getList);
                      // ignore: unnecessary_null_comparison
                      if (getList != null) {
                        showErrorDialog();
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  const SignUp()));
                      }
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white, width: 5.0)),
                        padding: const EdgeInsets.all(20.0),
                        child: const Text('Donate',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
