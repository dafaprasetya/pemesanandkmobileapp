import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool processReset = false;
final oldpasswordRController = TextEditingController();
final passwordRController = TextEditingController();
final confirmPRController = TextEditingController();
String? errorText;


Future<void> resetPassword(BuildContext context, VoidCallback onSuccess, passowrdOld, passwordNew) async {
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  // print("password lama: $passowrdOld");
  // print("password baru: $passwordNew");
  try {
    processReset = true;
    Response response = await dio.post(
      domain+'/api/auth/passwordReset',
      data: {
        "password_old" : passowrdOld,
        "password_new" : passwordNew,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
    );
    print(response.data);
    Map<String, dynamic> data = response.data;
    // print(data);
    if(data['status'] == 'success'){
      processReset = false;
      toastberhasil(context, 'Perubahan Password Berhasil', false);
      onSuccess();
    }else{
      processReset = false;
      toastgagal(context, 'Password Tidak Sesuai!', false);
      onSuccess();
    }
  } catch (e) {
    processReset = false;
    toastgagal(context, 'Password Tidak Sesuai!', false);
    print('gagal mendapatkan user: $e');
    onSuccess();
  }
}