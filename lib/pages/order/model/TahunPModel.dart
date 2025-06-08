import 'package:intl/intl.dart';

class TahunPModel {
  String idPesan;
  String kodePemesanan;
  String namaStokis;
  String hargaraw;
  String hargaTotal;
  String alamat;
  String status;
  String tanggal;
  
  static String formatRupiah(String nominal) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final parsed = double.tryParse(nominal)?.toInt() ?? 0;
    return currencyFormatter.format(parsed);
  }
  TahunPModel({
    required this.idPesan,
    required this.kodePemesanan,
    required this.hargaTotal,
    required this.hargaraw,
    required this.namaStokis,
    required this.alamat,
    required this.status,
    required this.tanggal,
  });

  factory TahunPModel.fromJson(Map<String, dynamic> json) {
    String harga = formatRupiah(json['harga_total'].toString());;
    return TahunPModel(
      
      idPesan: json['id_pesan'] ?? '',
      kodePemesanan: json['kode_pesanan'] ?? '',
      hargaTotal: harga ?? '',
      hargaraw: json['harga_total'] ?? '',
      namaStokis: json['nama_stokis'] ?? '',
      alamat: json['alamat'] ?? '',
      status: json['status_nama'] ?? '',
      tanggal: json['tanggal'] ?? '',
    );
  }
}