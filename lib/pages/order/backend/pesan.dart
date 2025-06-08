import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/order/filtercustompesan.dart';
import 'package:pemesanandk/pages/order/filterpesanan_page.dart';
import 'package:pemesanandk/pages/order/filtertahunpesan.dart';
import 'package:pemesanandk/pages/order/model/BulanPModel.dart';
import 'package:pemesanandk/pages/order/model/CustomPModel.dart';
import 'package:pemesanandk/pages/order/model/PesanKeranjangModel.dart';
import 'package:pemesanandk/pages/order/model/PesanModel.dart';
import 'package:pemesanandk/pages/order/model/SelectedPesanModel.dart';
import 'package:pemesanandk/pages/order/model/TahunPModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

bool isEmptyPesan = false;
bool isLoadingPesanKeranjang = false;
bool isLoadingPesan = false;
TextEditingController catatan = TextEditingController();
List<PesanModel> pesans = [];
List<SelectedPesanModel> selectedPesans = [];
List<PesanKeranjangModel> keranjangPesan = [];
bool popupBayar = false;
bool popupBatal = false;
final picker = ImagePicker();
File? gambar;
bool procesBayar = false;
bool procesBatal = false;

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
    print(response.data);
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

Future<void> batalkanPesanan(BuildContext context, VoidCallback onSuccess, idPesan, catatans) async {
    try {
      procesBatal = true;
      onSuccess();
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');
      dio.options.headers["Authorization"] = "Bearer $authToken";
      dio.options.connectTimeout = Duration(milliseconds: 50000);
      Response response = await dio.post(
        '$domain/api/pesan/batalkan',
        data: {
          "id_pesan" : idPesan,
          "jumlah" : catatans,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        )
      );
      onSuccess();
      if (response.data['status'] == "success") {
        procesBatal = false;
        popupBatal = false;
        gambar = null;
        print('anjayu berhasil');
        
        toastberhasil(context, 'Pesanan Berhasil Dibatalkan!', false);
        selectedPesans.last.status = "Batal";
        catatan.text = "";
        onSuccess();
      } else {
        procesBatal = false;
        toastgagal(context, 'Gagal!', false);
        onSuccess();
      }
    } catch (e) {
      // print(deskripsi.text);
      procesBatal = false;
      // print(gambar);
      print(e);
      toastgagal(context, 'Terjadi kesalahan harap coba lagi!', false);
      onSuccess();

    }
}
Future<void> bayarPesanan(BuildContext context, VoidCallback onSuccess, idPesan) async {
    if (gambar == null) {
      procesBayar = false;
      toastgagal(context, 'Masukan bukti pembayaran!', false);
      onSuccess();
      return;
    }
    try {
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');
      dio.options.headers["Authorization"] = "Bearer $authToken";
      dio.options.connectTimeout = Duration(milliseconds: 50000);
      FormData formData = FormData.fromMap({
        'id_pesan': idPesan,
        'bukti_transfer': await MultipartFile.fromFile(gambar!.path, filename: 'upload.jpg'),
      });
      procesBayar = true;
      onSuccess();
      Response response = await dio.post(
        '$domain/api/pesan/bayar',
        data: formData,
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


TextEditingController bulan = TextEditingController();
TextEditingController tahun = TextEditingController();
TextEditingController awal = TextEditingController();
TextEditingController akhir = TextEditingController();

Future<void> selectDate(VoidCallback onSuccess, BuildContext context, controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // tanggal default
      firstDate: DateTime(2000), // tanggal paling awal
      lastDate: DateTime(2101),  // tanggal paling akhir
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
      onSuccess();
    }
    onSuccess();
  }

void toastfilter(VoidCallback onSuccess, BuildContext context, customs, tahuns, bulans) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Menutup dialog
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    iconSize: 30,
                  ),
                  child: Icon(Icons.close),
                ),
              ),
              if(bulans)
                TextField(
                  controller: bulan,
                  readOnly: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Pilih Bulan",
                  ),
                  onTap: () => selectDate(() {}, context, bulan),
                ),
              if(bulans)
                ElevatedButton(onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> FilterPesanan() )
                  );
                }, child: Text('Cari')),

              
              if(tahuns)
                TextField(
                  controller: tahun,
                  readOnly: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Pilih Tahun",
                  ),
                  onTap: () => selectDate(() {}, context, tahun),
                ),
              if(tahuns)
                ElevatedButton(onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> TahunPesan() )
                  );
                }, child: Text('Cari')),

              if(customs)
                TextField(
                  controller: awal,
                  readOnly: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Pilih Awal",
                  ),
                  onTap: () => selectDate(() {}, context, awal),
                ),
              if(customs)
                TextField(
                  controller: akhir,
                  readOnly: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Pilih Akhir",
                  ),
                  onTap: () => selectDate(() {}, context, akhir),
                ),
              if(customs)
                ElevatedButton(onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> CustomPesanan() )
                  );
                }, child: Text('Cari')),
            ],
          ),
        ),
      );
    },
  );
}

List<BulanPModel> bulanPesanan = [];
List<TahunPModel> tahunPesanan = [];
List<CustomPModel> customPesanan = [];


Future<void> getPesanbyMonth(BuildContext context, VoidCallback onSuccess, bulanss) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    // bulanPesanan = 
    isLoadingPesan = true; 
    Response response = await dio.post(
      '$domain/api/pesan/getmonth',
      data: {
        "month" : bulanss,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
      
    );
    print(bulanss);
    print(response.data);
    if (response.data['status'] == 'success') {
      // List<dynamic> data = response.data['data'];
      bulanPesanan = (response.data['data'] as List).map((json) => BulanPModel.fromJson(json)).toList();
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
Future<void> getPesanbyYear(BuildContext context, VoidCallback onSuccess, yearss) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    // bulanPesanan = 
    isLoadingPesan = true; 
    Response response = await dio.post(
      '$domain/api/pesan/getyear',
      data: {
        "year" : yearss,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
      
    );
    // print(bulanss);
    print(response.data);
    if (response.data['status'] == 'success') {
      // List<dynamic> data = response.data['data'];
      tahunPesanan = (response.data['data'] as List).map((json) => TahunPModel.fromJson(json)).toList();
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
Future<void> getPesanbyCustom(BuildContext context, VoidCallback onSuccess, awals, akhirs) async{
  Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('authToken');
  dio.options.headers["Authorization"] = "Bearer $authToken";
  try {
    // bulanPesanan = 
    isLoadingPesan = true; 
    Response response = await dio.post(
      '$domain/api/pesan/getcustom',
      data: {
        "awal" : awals,
        "akhir" : akhirs,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      )
      
    );
    print(awals);
    print(akhirs);
    print(response.data);
    if (response.data['status'] == 'success') {
      // List<dynamic> data = response.data['data'];
      customPesanan = (response.data['data'] as List).map((json) => CustomPModel.fromJson(json)).toList();
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