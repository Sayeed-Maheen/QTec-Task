import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../utils/app_all_log/error_log.dart';
import '../../widgets/app_snack_bar/app_snack_bar.dart';
import '../storage_services/app_auth_storage.dart';
import 'api.dart';

class ApiGetServices {
  final api = AppApi();

  apiGetServices(
    String url, {
    int statusCode = 200,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      final response = await api.sendRequest.get(
        url,
        queryParameters: queryParameters,
        data: body,
      );
      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      AppSnackBar.error("Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      // AppSnackBar.error("Something Went Wrong");

      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 400) {
          if (e.response?.data["message"].runtimeType != Null) {
            AppSnackBar.error("${e.response?.data["message"]}");
          }
          return null;
        } else if (e.response?.statusCode == 401) {
          // AppSnackBar.error("Your login section has time out ");
          await AppAuthStorage().storageClear();
          //Get.offAllNamed(AppRoutes.loginScreen);
          // AppSnackBar.message("Sign-in again with your credential");
        }
      } else {
        // AppSnackBar.error("Something Went Wrong");
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      // AppSnackBar.error("Something Went Wrong");
      errorLog('api exception', e);
      return null;
    }
  }
}
