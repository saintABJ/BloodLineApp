
import 'package:flutter/material.dart';
import 'package:grazac_blood_line_app/resources/services.dart';
import 'package:grazac_blood_line_app/ui/donors_list.dart';
import 'package:grazac_blood_line_app/ui/add_blood_sample.dart';
import 'package:grazac_blood_line_app/ui/add_blood_sample.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  bool isLoggedIn = false;
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  

  // getUser() async {
  //   var user = await FirebaseAuthProvider().getCurrentUser();
  //   if (user == null) {
  //     setState(() {
  //       isLoggedIn = true;
  //     });
  //   }
  // }

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

  // @override
  // void initState() {
  //   super.initState();
  //   getUser();
  // }

  // showSnackbar(message) {
  //   _scaffoldkey.currentState.showSnackBar(SnackBar(
  //     backgroundColor: Colors.purple,
  //     content: Text(message ?? "Something went wrong, try again later."),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: const Text(
          'BloodLine',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // actions: <Widget>[
        //   isLoggedIn
        //       ? const SizedBox()
        //       // : IconButton(
        //       //     icon: const Icon(Icons.logout),
        //       //     onPressed: () async {
        //       //       // await FirebaseAuthProvider().logout();
        //       //       // showSnackbar('You are logged out');
        //       //       // getUser();
        //       //     })
        // ],
        // backgroundColor: Colors.red.shade900,
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
