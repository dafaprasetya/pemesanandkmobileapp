import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/order/model/PesanKeranjangModel.dart';
import 'package:pemesanandk/pages/order/model/PesanModel.dart';
import 'package:pemesanandk/pages/order/model/SelectedPesanModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

bool isEmptyPesan = false;
bool isLoadingPesanKeranjang = false;
bool isLoadingPesan = false;
List<PesanModel> pesans = [];
List<SelectedPesanModel> selectedPesans = [];
List<PesanKeranjangModel> keranjangPesan = [];
bool popupBayar = false;
final picker = ImagePicker();
File? gambar;
bool procesBayar = false;

Future<void> getPesan(BuildContext context, VoidCallback onSuccess) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    isLoadingPesan = true; 
    Response response = await dio.post(
      '$domain/api/pesan/getall',
    );
    print(response.data['status']);
    if (response.data['status'] == 'success') {
      List<dynamic> data = response.data['data'];
      pesans = (response.data['data'] as List).map((json) => PesanModel.fromJson(json)).toList();
      isLoadingPesan = false;
      isEmptyPesan = false;
      onSuccess();
    }else{
      isEmptyPesan = true;
      isLoadingPesan = false;
      onSuccess();
    }
    
    // print(reports[0].deskripsiPekerjaan);
  } catch (e) {
      isEmptyPesan = true;
      onSuccess();
      print('yahgagassl: $e');
  }
}
Future<void> getPesanKeranjang(BuildContext context, VoidCallback onSuccess, idPesan) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  // print(idPesan);
  try {
    isLoadingPesanKeranjang = true; 
    Response response = await dio.post(
      '$domain/api/pesan/getkeranjang',
        data: {
          "id_pesan" : idPesan,
          // "jumlah" : jumlah,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        )
    );
    if (response.data['data']["status"] == 'success') {
      // List<dynamic> data = response.data['data'];
      keranjangPesan = (response.data['data']['cart'] as List).map((json) => PesanKeranjangModel.fromJson(json)).toList();
      // print(response.data);
      isLoadingPesanKeranjang = false;
      onSuccess();
    }else{
      // print(response.data);
      isLoadingPesanKeranjang = false;
      onSuccess();
    }
    
    // print(reports[0].deskripsiPekerjaan);
  } catch (e) {
      isLoadingPesanKeranjang = false;
      toastgagal(context, "Oops, terjadi kesalahan", false);
      onSuccess();
      print('yahgagassl: $e');
  }
}

Future<void> pickImage(BuildContext context, VoidCallback onSuccess) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      gambar = File(pickedFile.path);
    }
    onSuccess();

}
Future<void> bayarPesanan(BuildContext context, VoidCallback onSuccess, idPesan) async {
    if (gambar == null) {
      procesBayar = false;
      toastgagal(context, 'Masukan bukti pembayaran!', false);
      onSuccess();
      return;
    }
    try {
      procesBayar = true;
      onSuccess();
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');
      dio.options.headers["Authorization"] = "Bearer $authToken";
      dio.options.connectTimeout = Duration(milliseconds: 50000);
      FormData formData = FormData.fromMap({
        'id_pesan': idPesan,
        'bukti_transfer': await MultipartFile.fromFile(gambar!.path, filename: 'upload.jpg'),
      });
      Response response = await dio.post(
        '$domain/api/pesan/bayar',
        data: formData
      );
      onSuccess();
      if (response.data['status'] == "success") {
        procesBayar = false;
        popupBayar = false;
        gambar = null;
        print('anjayu berhasil');
        
        toastberhasil(context, 'Bukti pembayaran berhasil dikirim!', false);
        selectedPesans.last.status = "Sudah Bayar";
        onSuccess();
      } else {
        procesBayar = false;
        toastgagal(context, 'Gagal!', false);
        onSuccess();
      }
    } catch (e) {
      // print(deskripsi.text);
      procesBayar = false;
      // print(gambar);
      print(e);
      toastgagal(context, 'Terjadi kesalahan harap coba lagi!', false);
      onSuccess();

    }
}