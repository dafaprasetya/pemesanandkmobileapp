import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pemesanandk/auth/loginpage.dart';
import 'package:pemesanandk/pages/home_page.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:permission_handler/permission_handler.dart';


final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
String authToken = '';
bool toastfaillogin = true;



void checkLogin(BuildContext context) async {
  
  await Permission.storage.request();
  await Permission.photos.request();
  await Permission.location.request();
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
    print(data);
    if(data['status'] == 'success'){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
        (Route<dynamic> route) => false,
      );
    }else{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
        (Route<dynamic> route) => false, 
      );
      toastgagal(context, 'User Tidak Ditemukan', false);

    }
  } catch (e) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loginpage()),
      (Route<dynamic> route) => false, 
    );
    print('gagal mendapatkan user: $e');
  }
}



void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken');
  await prefs.remove('nama');
  await prefs.remove('kode');
  await prefs.remove('stokis');
  await prefs.remove('alamat');
  await prefs.remove('user_id');
  print('berhasil logout');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Loginpage()),
    (route) => false,
  );
}

void login(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('kode', emailController.text);
  await prefs.setString('password', passwordController.text);
  // print('success');
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      domain+'/api/auth/login',
      data: {
        "kode" : emailController.text,
        "password" : passwordController.text,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
      
    );
    print('KODE: ${emailController.text}');
    print('PASSWORD: ${passwordController.text}');

    // print(response.data);
    Map<String, dynamic> data = response.data;
    authToken = data['token'];
    await prefs.setString('authToken', data['token']);
    await prefs.setString('nama', data['nama']);
    await prefs.setString('kode', data['kode']);
    await prefs.setString('stokis', data['stokis']);
    await prefs.setString('alamat', data['alamat']);
    await prefs.setString('user_id', data['user_id']);
    print(authToken);
    
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      (Route<dynamic> route) => false, // Hapus semua halaman sebelumnya
    );
  } on DioError catch (e) {
    toastgagal(context, 'Email/Password Salah!', false);
    print('gabisa euyy : $e');
  }
}

Future<void> loadUser(BuildContext context) async {
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    Response response = await dio.get(
      domain+'/api/auth/profile',
    );
    Map<String, dynamic> data = response.data['data'];
    print(data['user_id']);
  } catch (e) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loginpage()),
      (Route<dynamic> route) => false, // Hapus semua halaman sebelumnya
    );
    print('yahgagal: $e');
  }
    
}