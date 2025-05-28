class ProductModel {
  final String id;
  final String namaProduk;
  final String harga;
  final String stok;

  ProductModel({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.stok,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['barang_id'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      harga: json['harga_mitra'] ?? '',
      stok: json['stok1'] ?? '',
    );
  }
}