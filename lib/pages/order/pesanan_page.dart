import 'package:flutter/material.dart';
import 'package:pemesanandk/pages/order/backend/pesan.dart';
import 'package:pemesanandk/pages/order/model/SelectedPesanModel.dart';
import 'package:pemesanandk/pages/order/selectedpesan_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Order();
  }
}

class _Order extends StatefulWidget {
  const _Order({super.key});

  @override
  State<_Order> createState() => __OrderState();
}

class __OrderState extends State<_Order> {

  @override
  Future<void> _handleRefresh() async {
    // Simulasi delay 2 detik (misal ambil data dari API)
    await Future.delayed(Duration(seconds: 2));

    // Jalankan logika yang ingin kamu lakukan, misalnya fetch data baru
    setState(() {
      getPesan(context, () {
        setState(() {});
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPesan(context, () {
      setState(() {});
    });
    selectedPesans = [];
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        // foregroundColor: const Color(0xFFFAFAFA),
        surfaceTintColor: const Color(0xFFFAFAFA),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu), // ikon garis 3 (hamburger)
            color: const Color(0xFFE53935),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // buka drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: const Color(0xFFE53935),),
            onPressed: () {
              // aksi ketika tombol ditekan
            },
          ),
        ],
      ),
      body: 
      Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Stack(
                      children: [
                        isLoadingPesan ? Center(child: CircularProgressIndicator(color: const Color(0xFFE53935),)) :
                        isEmptyPesan ? Center(child: Text("Pesanan kosong"),) :
                        RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: 
                          ListView.builder(
                            itemCount: pesans.length,
                            itemBuilder: (context, index){
                              var ord = pesans[index];
                              return
                              GestureDetector(
                                onTap: () {
                                  SelectedPesanModel selected = SelectedPesanModel(
                                    kodePemesanan: ord.kodePemesanan,
                                    alamat: ord.alamat,
                                    hargaTotal: ord.hargaTotal,
                                    hargaraw: ord.hargaraw,
                                    idPesan: ord.idPesan,
                                    namaStokis: ord.namaStokis,
                                    status: ord.status,
                                    tanggal: ord.tanggal,
                                  );
                                  selectedPesans.add(selected);
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => PesanPage()),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Icon(
                                            Icons.receipt_long, size: 70,
                                            // color: const Color(0xFFE53935),
                                            color:
                                              ord.status == "Belum Bayar" ? const Color(0xFFE53935) :
                                              ord.status == "Sudah Bayar" ? Color(0xFF43A047) : ord.status == "Selesai" ? Color(0xFF43A047) : Color(0xFF757575)
                                          )
                                        ),
                                        SizedBox(width: 12,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ord.kodePemesanan,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // SizedBox(height: 8),
                                              Text(
                                                '${ord.namaStokis} - ${ord.alamat}}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: 
                                                    Text(
                                                      '${ord.hargaTotal}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(child: 
                                                    Text(
                                                      '${ord.status}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        decoration: TextDecoration.none,
                                                        color: 
                                                          ord.status == "Belum Bayar" ? const Color(0xFFE53935) :
                                                          ord.status == "Sudah Bayar" ? Color(0xFF43A047) : Color(0xFF757575)
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text("Tanggal Pemesanan: ${ord.tanggal}")
                                            ],
                                          )       
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              );
                            }
                            )
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ],
      )
    );
  }
}