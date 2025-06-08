import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/cart/model/CartModel.dart';
import 'package:pemesanandk/pages/cart/model/SelectedCartModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

bool isLoadingCart = false;
String jumlahs = '';
TextEditingController jumlahController = TextEditingController(text: jumlahs);
bool isEmptyCart = true;
String total = '0';
bool successKeranjang = false;
bool successDeleteKeranjang = false;
bool errorKeranjang = false;
bool showPopup = false;
List<CartModel> carts = [];
List<SelectedCartModel> selectedItem = [];
bool processedEdit = false;
bool processedAddPesanan = false;
String totalHarga = "0";

String formatRupiah(dynamic nominal) {
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return currencyFormatter.format(int.tryParse(nominal.toString()) ?? 0);
}


void showSuccessNotif() {

  errorKeranjang = false;
  successKeranjang = true;
  showPopup = false;
  selectedItem = [];
  total = total;
  // jumlahController.text = jumlahs;

  Future.delayed(Duration(seconds: 1), () {
    errorKeranjang = false;
    successKeranjang = false;
  });
}
void showSuccessDeleteNotif() {

  errorKeranjang = false;
  successKeranjang = false;
  successDeleteKeranjang = true;
  showPopup = false;
  selectedItem = [];
  total = total;
  // jumlahController.text = jumlahs;

  Future.delayed(Duration(seconds: 1), () {
    errorKeranjang = false;
    successKeranjang = false;
    successDeleteKeranjang = false;
  });
}
void showErrorNotif() {
  errorKeranjang = true;
  successKeranjang = false;
  showPopup = false;

  Future.delayed(Duration(seconds: 1), () {
    errorKeranjang = false;
    successKeranjang = false;
  });
}


Future<void> getCart(BuildContext context, VoidCallback onSuccess) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    isLoadingCart = true;
    Response response = await dio.post(
      '$domain/api/keranjang/get',
    );
    if (response.data['status'] == 'success') {
      List<dynamic> data = response.data['data']['cart'];
      print(response.data['status']);
      isEmptyCart = false;
      carts = (response.data['data']['cart'] as List).map((json) => CartModel.fromJson(json)).toList();
      int totalint = data.fold(0, (prev, item) {
        return prev + (int.tryParse(item['harga_total'].toString().split('.')[0]) ?? 0);
      });
      totalHarga = totalint.toString();
      isLoadingCart = false;
      // jumlahs = response.data
      onSuccess();
    }else{
      isEmptyCart = true;
      isLoadingCart = false;
      onSuccess();
    }
    
    // print(reports[0].deskripsiPekerjaan);
  } catch (e) {
      isEmptyCart = true;
      onSuccess();
      print('yahgagassl: $e');
  }
}
Future<void> getCartRealtime(BuildContext context, VoidCallback onSuccess) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    Response response = await dio.post(
      '$domain/api/keranjang/get',
    );
    print(response.data['status']);
    if (response.data['status'] == 'success') {
      List<dynamic> data = response.data['data']['cart'];
      carts = (response.data['data']['cart'] as List).map((json) => CartModel.fromJson(json)).toList();
      int totalint = data.fold(0, (prev, item) {
        return prev + (int.tryParse(item['harga_total'].toString().split('.')[0]) ?? 0);
      });
      totalHarga = totalint.toString();
      onSuccess();
    }else{
      isEmptyCart = true;
      onSuccess();
    }
  } catch (e) {
      isEmptyCart = true;
      onSuccess();
      print('yahgagassl: $e');
  }
}
Future<void> updateCart(BuildContext context, VoidCallback onSuccess, idKeranjang, jumlah) async{
  if (jumlahController.text.isEmpty || jumlahController.text == "0" || jumlahController.text == 0.toString() || (int.tryParse(jumlahController.text) ?? 0) < 0) {
    processedEdit = false;
    toastgagal(context, 'Jumlah pesanan tidak boleh kosong!', false);
  }else{

    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    dio.options.headers["Authorization"] = "Bearer $authToken";
    try {
      processedEdit = !processedEdit;
      Response response = await dio.post(
        '$domain/api/keranjang/edit',
        data: {
          "id_keranjang" : idKeranjang,
          "jumlah" : jumlah,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        )
      );
      // List<dynamic> data = response.data['data']['cart'];
      print(response.data);
      if (response.data['status'] == 'success') {
        showSuccessNotif();
        processedEdit = !processedEdit;
        // final index = carts.indexWhere((e) => e.keranjangId == idKeranjang);
        // carts[index].jumlah = jumlah.toString();
        // int hargaSatuan = int.tryParse(carts[index].hargaMitra) ?? 0;
        // int jumlahInt = int.tryParse(jumlah.toString()) ?? 0;
        // int hargaTotalBaru = hargaSatuan != 0 ? hargaSatuan * jumlahInt : 0;
        
        // carts[index].hargaraw = hargaTotalBaru.toString();
        // carts[index].hargaTotal = CartModel.formatRupiah(hargaTotalBaru.toString());
        getCartRealtime(context, onSuccess);
        onSuccess();
      }else{
        processedEdit = !processedEdit;
        toastgagal(context, 'Terjadi kesalahan', false);

      }
      
      // print(reports[0].deskripsiPekerjaan);
    } catch (e) {
        processedEdit = !processedEdit;
        toastgagal(context, 'Sambungan internet bermasalah!', false);
        print('yahgagassl: $e');
    }
  }
}

Future<void> deleteCart(BuildContext context, VoidCallback onSuccess, idKeranjang) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    processedEdit = !processedEdit;
    Response response = await dio.post(
      '$domain/api/keranjang/delete',
      data: {
        "id_keranjang" : idKeranjang,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
    );
    // List<dynamic> data = response.data['data']['cart'];
    print(response.data);
    if (response.data['status'] == 'success') {
      showSuccessDeleteNotif();
      processedEdit = !processedEdit;
      getCartRealtime(context, onSuccess);
      onSuccess();
    }else{
      processedEdit = !processedEdit;
      toastgagal(context, 'Terjadi kesalahan', false);

    }
    
  } catch (e) {
      processedEdit = !processedEdit;
      toastgagal(context, 'Sambungan internet bermasalah!', false);
      print('yahgagassl: $e');
  }
}
Future<void> addPesanan(BuildContext context, VoidCallback onSuccess) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    processedAddPesanan = !processedAddPesanan;
    Response response = await dio.post(
      '$domain/api/pesan/add',
    );
    // List<dynamic> data = response.data['data']['cart'];
    print(response.data);
    if (response.data['status'] == 'success') {
      toastberhasil(context, "Pesanan berhasil ditambahkan!", false);
      processedAddPesanan = !processedAddPesanan;
      getCartRealtime(context, onSuccess);
      onSuccess();
    }else if(response.data['status'] == 'error'){
      processedAddPesanan = !processedAddPesanan;
      toastgagal(context, 'Keranjang Kosong!', false);

    }
    
  } catch (e) {
      processedAddPesanan = !processedAddPesanan;
      toastgagal(context, 'Sambungan internet bermasalah!', false);
      print('yahgagassl: $e');
  }
}
