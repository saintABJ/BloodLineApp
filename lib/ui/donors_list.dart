// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grazac_blood_line_app/model/user_model.dart';
import 'package:grazac_blood_line_app/resources/services.dart';
import 'package:grazac_blood_line_app/ui/background_screen.dart';
import 'package:flutter/material.dart';
import 'package:grazac_blood_line_app/ui/home_screen.dart';
import 'package:grazac_blood_line_app/ui/profile_screen.dart';
import 'package:grazac_blood_line_app/ui/add_blood_sample.dart';

class DonorsList extends StatefulWidget {
  final List<UserModel> donors;
  DonorsList({required this.donors});

  @override
  _DonorsListState createState() => _DonorsListState();
}

class _DonorsListState extends State<DonorsList> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  UserModel user = UserModel();

  List blood = ['All', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-'];
  String selectedValue = 'All';

  getList() {
    // ignore: unnecessary_null_comparison
    if (widget.donors == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else
      return Column(
        children: <Widget>[
          ListTile(
              // ignore: unnecessary_null_comparison
              leading: selectedValue != null
                  ? Text(
                      selectedValue,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Filter',
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
                  // getUserModel();
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
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: widget.donors.length,
                itemBuilder: (context, index) {
                  var donors = widget.donors[index];
                  return ListTile(
                    onLongPress: () {},
                    onTap: () async {                   
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(donors: donors)));
                    },
                    title: Column(
                      children: [
                        Container(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16.0, 30.0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Name: ${donors.userName}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Image(
                                      image: AssetImage(
                                          'images/bloodline_icon.png'),
                                      height: 50,
                                      width: 50,
                                    ),
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
                                        ' ${donors.bloodGroup}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [Text('Click to view details')],
                                ),
                                Spacer(),
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
                      ],
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
          leading: IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          title: Text('Donors'),
          actions: <Widget>[],
        ),
        body: getList());
  }
}
