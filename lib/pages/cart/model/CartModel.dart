import 'package:intl/intl.dart';

class CartModel {
  String keranjangId;
  String userId;
  String hargaTotal;
  String hargaraw;
  String jumlah;
  String namaProduk;
  String kategori;
  String grup;
  String satuan;
  String stok;
  String hargaMitra;
  
  static String formatRupiah(String nominal) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final parsed = double.tryParse(nominal)?.toInt() ?? 0;
    return currencyFormatter.format(parsed);
  }
  CartModel({
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

  factory CartModel.fromJson(Map<String, dynamic> json) {
    String harga = formatRupiah(json['harga_total'].toString());;
    return CartModel(
      
      keranjangId: json['keranjang_id'] ?? '',
      userId: json['user_id'] ?? '',
      hargaTotal: harga ?? '',
      hargaraw: json['harga_total'] ?? '',
      jumlah: json['jumlah'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      satuan: json['satuan'] ?? '',
      kategori: json['kategori'] ?? '',
      grup: json['grup'] ?? '',
      stok: json['stok'] ?? '',
      hargaMitra: json['harga_mitra'] ?? '',
    );
  }
}