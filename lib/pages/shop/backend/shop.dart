import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/shop/model/ProductModel.dart';
import 'package:pemesanandk/pages/shop/model/SearchProdModel.dart';
import 'package:pemesanandk/pages/shop/model/SelectedProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

final TextEditingController searchController = TextEditingController();
final TextEditingController jumlahController = TextEditingController(text: '0');
bool isloadingProduct= false; 
bool isloadingProdSearch= false; 
bool prodSearchEmpty = false;
bool successKeranjang = false;
bool errorKeranjang = false;
bool processedKeranjang = false;
List<ProductModel> products = [];
List<SearchProdModel> productSearch = [];
bool showPopup = false;
List<SelectedProduct> selectedItem = [];
var total = '0';
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
  total = '0';
  jumlahController.text = '0';

  Future.delayed(Duration(seconds: 1), () {
    errorKeranjang = false;
    successKeranjang = false;
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


Future<void> getProduct(BuildContext context, VoidCallback onSuccess) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  
  isloadingProduct = !isloadingProduct;
  
  try {
    Response response = await dio.post(
      '$domain/api/products/get',
    );
    List<dynamic> data = response.data['products'];
    // print(data);
    products = (response.data['products'] as List).map((json) => ProductModel.fromJson(json)).toList();
    isloadingProduct = !isloadingProduct;
    onSuccess();
    // print(reports[0].deskripsiPekerjaan);
  } catch (e) {
    print('yahgagassl: $e');
  }
}
final List<String> itemsSearchInput = [];

Future<List<String>> getProductForDropdown() async {
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";

  try {
    Response response = await dio.post('$domain/api/products/get');

    if (response.statusCode == 200 && response.data['status'] == 'success') {
      List<dynamic> datas = response.data['products'];
      
      itemsSearchInput.clear(); // kosongkan dulu
      itemsSearchInput.addAll(
        datas.map((item) => item['nama_produk'].toString())
      );

      return itemsSearchInput;
    } else {
      throw Exception('Gagal memuat data');
    }
  } catch (e) {
    print('Error load product: $e');
    return [];
  }
}
Future<void> getProductSearch(BuildContext context, VoidCallback onSuccess) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
    isloadingProdSearch = !isloadingProdSearch;
  try {
    
    Response response = await dio.post(
      '$domain/api/products/getSearch',
      data: {
        "search" : searchController.text,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
    );
    List<dynamic> data = response.data['products'];
    if (response.data['status'] == 'empty') {
      print('KOSONG');
      prodSearchEmpty = !prodSearchEmpty;
      onSuccess();
    }else{
      print(data);
      prodSearchEmpty = false;
      // print(data);
      productSearch = (response.data['products'] as List).map((json) => SearchProdModel.fromJson(json)).toList();
      isloadingProdSearch = !isloadingProdSearch;
      onSuccess();
    }
    // print(reports[0].deskripsiPekerjaan);
  } catch (e) {
    print('yahgagassl: $e');
  }
}
Future<void> addToCart(BuildContext context, VoidCallback onSuccess, barangId, jumlah) async{
  if (jumlahController.text.isEmpty || jumlahController.text == "0" || jumlahController.text == 0.toString() || (int.tryParse(jumlahController.text) ?? 0) < 0) {
    processedKeranjang = false;
    toastgagal(context, 'Jumlah pesanan tidak boleh kosong!', false);
  } else {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    dio.options.headers["Authorization"] = "Bearer $authToken";
    // dio.options.headers["User-Agent"] = 'PostmanRuntime/7.29.2';
    try {
      processedKeranjang = true;
      Response response = await dio.post(
        '$domain/api/keranjang/add',
        data: {
          "barang_id": barangId,
          "jumlah": jumlahController.text,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        )
      );
      print(barangId);
      if (response.data['status'] == 'error') {
        print('Stok Tidak Tersedia!');
        // showErrorNotif();
        toastgagal(context, 'Stok Tidak Tersedia!', false);
        processedKeranjang = false;
        onSuccess();
      }
      else if(response.data['status'] == 'Exists'){
        print('Barang Sudah Ada Di Keranjang!');
        // showErrorNotif();
        toastgagal(context, 'Barang Sudah Ada Di Keranjang!', false);
        processedKeranjang = false;
        onSuccess();
      }
      else {
        print('berhasil');
        processedKeranjang = false;
        showSuccessNotif();
        onSuccess();
      }
    } catch (e) {
      processedKeranjang = false;
      toastgagal(context, 'Sambungan internet bermasalah!', false);
      // showErrorNotif();

      print('Gagal: $e');
    }
  }
}
