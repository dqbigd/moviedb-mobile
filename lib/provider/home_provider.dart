import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviedb/model/movie_model.dart';

import '../network/api_network.dart';

class HomeProvider extends ChangeNotifier {
  ApiNetwork apiNetwork = ApiNetwork();

  var isLoading = false;

  var listNowPlaying = <Movie>[];
  var respNowPlaying = MovieResponse();

  var connectionStatus = true;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  HomeProvider() {
    onInit();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void onInit() {
    initConnectivity();

    getNowPlayingData();
  }

  getNowPlayingData() async {
    isLoading = true;
    notifyListeners();
    try {
      MovieResponse? response = await apiNetwork.nowPlaying();

      if (response != null) {
        respNowPlaying = response;
        listNowPlaying = respNowPlaying.results!;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status : $e');
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        connectionStatus = true;
        break;
      case ConnectivityResult.wifi:
        connectionStatus = true;
        break;
      case ConnectivityResult.none:
        connectionStatus = false;
        break;
      default:
        debugPrint('Can\'t check connection!');
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
