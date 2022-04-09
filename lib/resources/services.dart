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
const String getAllRequest = baseURL + '/api/v1/viewBloodSamples';
const String getOneRequest =
    baseURL + '/api/v1/viewOneBloodSample/:624f9c06085d904f66e81212';
const String patchRequest =
    baseURL + '/api/v1/updateBloodSample/:621e728d5a7702473b818534';

class BloodSampleServices {
  static final Dio dio = Dio();

  static Future<String?> createPost(UserModel model) async {
    try {
      var response = await dio.post(postRequest, data: model.toJson());

      if (response.statusCode == 201) {
        return response.data["message"];
      } else {
        return "Unable to create Blood sample";
      }
    } catch (e) {
      if (e is SocketException) {
        return "No internet connection";
      } else {
        return "Unable to create Blood sample";
      }
    }
  }

  static Future<Tuple2<List<UserModel>?, String?>> getUserModel() async {
    final url = Uri.parse(getAllRequest);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var result = json.decode(response.body);

        List<UserModel> userModelList = List<UserModel>.from(
            result["showAll_BloodSample"]
                .map((model) => UserModel.fromJson(model)));
        return Tuple2(userModelList, null);
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


 static Future<String?> getSingleUser(UserModel model) async {
  final url = Uri.parse(getOneRequest);

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      UserModel data = UserModel.fromJson(json.decode(response.body));

      print(data);

      return response.body;
    } else {
      return ("unable to get User data");
    }
  } catch (e) {
    if (e is SocketException) {
      return ("No Internet Connection");
    }
    return ("unable to get User data");
  }
}


  // static final Dio dio = Dio();

  //   try {
  //     var response = await dio.post(postRequest, data: model.toJson());

  //     if (response.statusCode == 201) {
  //       return response.data["message"];
  //     } else {
  //       return "Unable to create Blood sample";
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       return "No internet connection";
  //     } else {
  //       return "Unable to create Blood sample";
  //     }
  //   }
  // }
}