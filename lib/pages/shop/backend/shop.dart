import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/shop/model/ProductModel.dart';
import 'package:pemesanandk/pages/shop/model/SelectedProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TextEditingController searchController = TextEditingController();
final TextEditingController jumlahController = TextEditingController(text: '1');
bool isloadingProduct= false; 
List<ProductModel> products = [];

Future<void> getProduct(BuildContext context, VoidCallback onSuccess) async{
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    dio.options.headers["Authorization"] = "Bearer $authToken";
    
      isloadingProduct = !isloadingProduct;
    
    try {
      Response response = await dio.post(
        domain+'/api/products/get',
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
