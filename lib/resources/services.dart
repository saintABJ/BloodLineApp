
import 'dart:convert';
import 'dart:io';

import 'package:grazac_blood_line_app/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';


const String baseURL = 'https://bloodline-app.herokuapp.com';
const String postRequest = baseURL + '/api/v1/addBloodSample';
const String getRequest = baseURL + '/api/v1/viewBloodSamples';

 Future<UserModel?> createPost(UserModel model) async {
  
  final Dio dio = Dio();
  
    try {
     
      var response = await dio.post(postRequest, data: model.toJson());

      if (response.statusCode == 201) {

        UserModel data = UserModel.fromJson(response.data);

        print(data);

      } else {
        response.statusMessage;
      }
    
      debugPrint(response.toString());
      
    }  catch (e) {
        print(e);
     // print('status code: ${e.response?.statusCode.toString()}');
      // throw Exception('Failed to load');
    }
  }

  
 Future<Tuple2<UserModel?, String?>> getUserModel() async {

    final url = Uri.parse(getRequest);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        UserModel data = UserModel.fromJson(json.decode(response.body));
        return Tuple2(data, null);
      } else {
        return const Tuple2(null, "unable to get User data");
      }
    } catch (e) {
      if (e is SocketException) {
        return const Tuple2(null, "No Internet Connection");
      }
      return const Tuple2(null, "unable to get User data");
    }
  }