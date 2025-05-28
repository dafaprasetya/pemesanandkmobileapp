import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:shared_preferences/shared_preferences.dart';

int selectedItems = 0;

String app_version = '1.0.0';

String? nama;
String? user_id;
String? kode;
String? stokis;
String? alamat;
String? level;

Future<void> loadProfile(BuildContext context, VoidCallback onSuccess) async {
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    Response response = await dio.get(
      domain+'/api/auth/profile',
    );
    print(response.data);
    Map<String, dynamic> data = response.data;
    // print(data);
    if(data['status'] == 'success'){
      nama = data['nama'];
      user_id = data['user_id'];
      kode = data['kode'];
      stokis = data['stokis'];
      alamat = data['alamat'];
      level = data['level'];
      user_id = prefs.getString('user_id');

      onSuccess();
    }else{
      toastgagal(context, 'gagal mendapatkan user', true);
    }
  } catch (e) {
  
    print('gagal mendapatkan user: $e');
  }
}