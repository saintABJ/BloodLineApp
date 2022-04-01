
import 'package:grazac_blood_line_app/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const String baseURL = 'https://bloodline-app.herokuapp.com';
const String postToEndPoint = baseURL + '/api/v1/addBloodSample';

 Future<UserModel?> createPost(UserModel model) async {
  
  final Dio dio = Dio();
    try {
     
      var response = await dio.post(postToEndPoint, data: model.toJson());

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
  

