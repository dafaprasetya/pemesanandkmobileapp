import 'package:flutter/material.dart';
import 'package:pemesanandk/pages/order/backend/pesan.dart';
import 'package:pemesanandk/pages/order/model/BulanPModel.dart';
import 'package:pemesanandk/pages/order/model/SelectedPesanModel.dart';
import 'package:pemesanandk/pages/order/selectedpesan_page.dart';


class CustomPesanan extends StatelessWidget {
  const CustomPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Customs();
  }
}

class Customs extends StatefulWidget {
  const Customs({super.key});

  @override
  State<Customs> createState() => _CustomsState();
}

class _CustomsState extends State<Customs> {
  Future<void> _handleRefresh() async {
    // Simulasi delay 2 detik (misal ambil data dari API)
    await Future.delayed(Duration(seconds: 2));

    // Jalankan logika yang ingin kamu lakukan, misalnya fetch data baru
    setState(() {
      getPesanbyCustom(context, () {
        setState(() {});
      }, awal.text, akhir.text);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPesanbyCustom(context, () {
      setState(() {});
    }, awal.text, akhir.text);
    print(awal.text + akhir.text);
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Berdasarkan Tanggal'),
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
                            itemCount: customPesanan.length,
                            itemBuilder: (context, index){
                              var ord = customPesanan[index];
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
      ),
      
    );
  }
}