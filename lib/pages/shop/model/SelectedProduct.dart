class SelectedProduct {
  final String id;
  final String namaProduk;
  final String harga;
  final String stok;

  SelectedProduct({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.stok,
  });

  factory SelectedProduct.fromJson(Map<String, dynamic> json) {
    return SelectedProduct(
      id: json['barang_id'] ?? '',
      namaProduk: json['nama_produk'] ?? '',
      harga: json['harga_mitra'] ?? '',
      stok: json['stok1'] ?? '',
    );
  }
}