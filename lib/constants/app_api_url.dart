import 'package:flutter/foundation.dart';

import '../utils/app_all_log/error_log.dart';

String _getDomain() {
  String serverDomain = "https://fakestoreapi.com"; //////////// live server
  String localDomain = "https://fakestoreapi.com"; ///////// local server
  try {
    if (kReleaseMode) {
      return serverDomain;
    } else {
      return localDomain;
    }
  } catch (e) {
    errorLog("_getDomain", e);
    return serverDomain;
  }
}

class AppApiUrl {
  AppApiUrl._();

  //////////////////////////////////////  base
  static const String localDomain =
      "https://fakestoreapi.com"; ///////// local server
  static const String serverDomain =
      "https://fakestoreapi.com"; //////////// live server
  static final String domain = _getDomain();

  // static final String domain = serverDomain;
  static final String baseUrl = domain;
  static final String product = "$baseUrl/products";
}
