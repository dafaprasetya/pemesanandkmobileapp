import 'package:intl/intl.dart';

class SearchProdModel {
  final String id;
  final String namaProduk;
  final String harga;
  final String hargaraw;
  final String stok;
  final String satuan;
  final String kategori;
  final String grup;

  static String formatRupiah(dynamic nominal) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(int.tryParse(nominal.toString()) ?? 0);
  }
  SearchProdModel({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.hargaraw,
    required this.stok,
    required this.satuan,
    required this.kategori,
    required this.grup,
  });

  factory SearchProdModel.fromJson(Map<String, dynamic> json) {
    String hargaMitra = formatRupiah(json['harga_mitra']);
    return SearchProdModel(
      
      id: json['barang_id'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      harga: hargaMitra ?? '',
      hargaraw: json['harga_mitra'] ?? '',
      stok: json['stok'] ?? '',
      satuan: json['satuan'] ?? '',
      kategori: json['kategori'] ?? '',
      grup: json['grup'] ?? '',
    );
  }
}