// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures


import 'package:grazac_blood_line_app/model/user_model.dart';
import 'package:grazac_blood_line_app/resources/services.dart';
import 'package:grazac_blood_line_app/ui/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:grazac_blood_line_app/ui/donors_list_tile.dart';

class DonorsList extends StatefulWidget {

  DonorsList({required this.donors})
  

  late List<UserModel> donors;
  List blood = ['All', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-'];  

  @override
  _DonorsListState createState() => _DonorsListState();
}

class _DonorsListState extends State<DonorsList> { 
  
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String selectedValue = 'All';
  List blood = ['All', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-'];
  
getList() {
    // if (donors == null) {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // } else
      var donors;
      return Column(
        children: <Widget>[
          ListTile(
              leading: selectedValue != null
                  ? Text(
                      selectedValue,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'filtwer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              trailing: PopupMenuButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  setState(() {
                    selectedValue = 'value';
                  });
                  getUserModel();
                },
                itemBuilder: (BuildContext context) => blood
                    .map((b) => PopupMenuItem(
                          child: Text(b),
                          value: b,
                        ))
                    .toList(),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                // itemCount: donors.length,
                itemBuilder: (context, i) {
                 
                    return ListTile(
                      onTap: () {
                        
                      },
                      title: Container(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16.0, 30.0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Name:${donors.userName}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.water,
                                    size: 55,
                                    color: Colors.red.shade800,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Phone Number: ${donors.phoneNumber}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      'BloodGroup ${donors.bloodGroup}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      height: 2.0,
                                      width: 18.0,
                                      color: Color(0xff00d6ff)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        height: 154.0,
                        margin: EdgeInsets.only(top: 12.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.red, Colors.teal]),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[900],
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text('Donors'),

          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.list),
            //   onPressed: () {
            //     setState(() {
                  
            //     });
            //   },
            // )
          ],
        ),
        body: getList());
  }
}


