import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import 'app_exception.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 30;
  final String baseUrl = Constant.baseUrl;

  //GET
  Future<dynamic> get(String api) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var response = await http
          .get(uri, headers: null)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.statusCode != 200) {}
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      default:
        // Get.snackbar(
        //     'Oops!', 'Error occured with code : ${response.statusCode}',
        //     snackPosition: SnackPosition.BOTTOM,
        //     margin: const EdgeInsets.all(16));
        return null;
    }
  }
}
