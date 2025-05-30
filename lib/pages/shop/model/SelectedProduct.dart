import 'package:intl/intl.dart';

class SelectedProduct {
  final String id;
  final String namaProduk;
  final String harga;
  final String hargaraw;
  final String stok;
  final String satuan;
  static String formatRupiah(dynamic nominal) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(int.tryParse(nominal.toString()) ?? 0);
  }
  SelectedProduct({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.hargaraw,
    required this.stok,
    required this.satuan,
  });

  factory SelectedProduct.fromJson(Map<String, dynamic> json) {
    String hargaMitra = formatRupiah(json['harga_mitra']);
    return SelectedProduct(
      
      id: json['barang_id'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      harga: hargaMitra ?? '',
      hargaraw: hargaMitra ?? json['harga_mitra'],
      stok: json['stok'] ?? '',
      satuan: json['satuan'] ?? '',
    );
  }
}