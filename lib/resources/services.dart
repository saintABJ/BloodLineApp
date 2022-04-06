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
    final url = Uri.parse(getRequest);

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
}
