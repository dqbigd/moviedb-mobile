import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../utils/constant.dart';
// import '../utils/dialog_helper.dart';

// class BaseClient {
//   static const int TIME_OUT_DURATION = 30;
//   final String baseUrl = Constant.baseUrl;
//
//   SharedPreferencesManager sharedPreferencesManager =
//       SharedPreferencesManager();
//
//   //GET
//   Future<dynamic> get(String api, {bool usingToken = true}) async {
//     var uri = Uri.parse(baseUrl + api);
//     var token = '';
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString(sharedPreferencesManager.KEY_TOKEN)!;
//
//     try {
//       var response = await http
//           .get(uri,
//               headers: usingToken
//                   ? {
//                       'Content-Type': 'application/json',
//                       'Accept': 'application/json',
//                       'Authorization': 'Bearer $token',
//                     }
//                   : null)
//           .timeout(Duration(seconds: TIME_OUT_DURATION));
//       if (response.statusCode != 200) {
//         debugPrint('${response.statusCode} | ' + api);
//       }
//       return _processResponse(response);
//     } on SocketException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'No connection');
//       }
//       // throw FetchDataException('No Internet connection', uri.toString());
//     } on TimeoutException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'API not responded in time');
//       }
//       // throw ApiNotRespondingException('API not responded in time', uri.toString());
//     }
//   }
//
//   //POST
//   Future<dynamic> post(String api, dynamic body,
//       {bool usingToken = true}) async {
//     var uri = Uri.parse(baseUrl + api);
//     var token = '';
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     if (usingToken) {
//       token = prefs.getString(sharedPreferencesManager.KEY_TOKEN)!;
//     }
//
//     try {
//       var response = await http
//           .post(uri,
//               headers: usingToken
//                   ? {
//                       'Content-Type': 'application/json',
//                       'Accept': 'application/json',
//                       'Authorization': 'Bearer $token',
//                     }
//                   : null,
//               body: body)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       if (response.statusCode != 200 || response.statusCode != 201) {
//         debugPrint('${response.statusCode} | ' + api);
//       }
//       return _processResponse(response);
//     } on SocketException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'No connection');
//       }
//     } on TimeoutException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'API not responded in time');
//       }
//     }
//   }
//
//   //PUT
//   Future<dynamic> put(String api, dynamic payload,
//       {bool usingToken = true}) async {
//     var uri = Uri.parse(baseUrl + api);
//     var token = '';
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString(sharedPreferencesManager.KEY_TOKEN)!;
//
//     try {
//       var response = await http
//           .put(uri,
//               headers: usingToken
//                   ? {
//                       'Content-Type': 'application/json',
//                       'Accept': 'application/json',
//                       'Authorization': 'Bearer $token',
//                     }
//                   : null,
//               body: payload)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       if (response.statusCode != 200) {
//         debugPrint('${response.statusCode} | ' + api);
//       }
//       return _processResponse(response);
//     } on SocketException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'No connection');
//       }
//     } on TimeoutException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'API not responded in time');
//       }
//     }
//   }
//
//   //DELETE
//   Future<dynamic> delete(String api, {bool usingToken = true}) async {
//     var uri = Uri.parse(baseUrl + api);
//     var token = '';
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString(sharedPreferencesManager.KEY_TOKEN)!;
//
//     try {
//       var response = await http
//           .delete(uri,
//               headers: usingToken
//                   ? {
//                       'Content-Type': 'application/json',
//                       'Accept': 'application/json',
//                       'Authorization': 'Bearer $token',
//                     }
//                   : null)
//           .timeout(Duration(seconds: TIME_OUT_DURATION));
//       if (response.statusCode != 200) {
//         debugPrint('${response.statusCode} | ' + api);
//       }
//       return _processResponse(response);
//     } on SocketException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'No connection');
//       }
//     } on TimeoutException {
//       if (!Get.isDialogOpen!) {
//         DialogHelper.showErrorDialog(description: 'API not responded in time');
//       }
//     }
//   }
//
//   dynamic _processResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         var responseJson = utf8.decode(response.bodyBytes);
//         return responseJson;
//       case 201:
//         var responseJson = utf8.decode(response.bodyBytes);
//         return responseJson;
//       default:
//         Get.snackbar(
//             'Oops!', 'Error occured with code : ${response.statusCode}',
//             snackPosition: SnackPosition.BOTTOM,
//             margin: const EdgeInsets.all(16));
//         return null;
//     }
//   }
// }
