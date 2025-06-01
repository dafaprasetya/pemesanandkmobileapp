import 'package:intl/intl.dart';

class SelectedCartModel {
  final String keranjangId;
  final String userId;
  final String hargaTotal;
  final String hargaraw;
  final String jumlah;
  final String namaProduk;
  final String kategori;
  final String grup;
  final String satuan;
  final String stok;
  final String hargaMitra;

  
  static String formatRupiah(String nominal) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final parsed = double.tryParse(nominal)?.toInt() ?? 0;
    return currencyFormatter.format(parsed);
  }
  SelectedCartModel({
    required this.keranjangId,
    required this.userId,
    required this.hargaTotal,
    required this.hargaraw,
    required this.jumlah,
    required this.namaProduk,
    required this.kategori,
    required this.grup,
    required this.satuan,
    required this.stok,
    required this.hargaMitra,

  });

  factory SelectedCartModel.fromJson(Map<String, dynamic> json) {
    String harga = formatRupiah(json['harga_total'].toString());;
    return SelectedCartModel(
      
      keranjangId: json['keranjang_id'] ?? '',
      userId: json['user_id'] ?? '',
      hargaTotal: harga ?? '',
      hargaraw: json['harga_total'] ?? '',
      jumlah: json['jumlah'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      satuan: json['satuan'] ?? '',
      kategori: json['kategori'] ?? '',
      grup: json['grup'] ?? '',
      hargaMitra: json['harga_mitra'] ?? '',
      stok: json['stok'] ?? '',
    );
  }
}