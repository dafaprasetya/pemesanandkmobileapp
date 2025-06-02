import 'package:flutter/material.dart';
import 'package:pemesanandk/pages/order/backend/pesan.dart';
import 'package:pemesanandk/pages/order/model/SelectedPesanModel.dart';

class PesanPage extends StatelessWidget {
  const PesanPage({super.key});

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
      
    });
  }
  @override
  SelectedPesanModel pesan = selectedPesans.last;
  void initState() {
    // TODO: implement initState
    super.initState();
    SelectedPesanModel pesan = selectedPesans.last;
    getPesanKeranjang(context, (){setState(() {});}, pesan.idPesan);
    gambar = null;
  }
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: 
        Stack(
          children: [
            Column(
              children: [
                Expanded(child: 
                
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          "Kode Pesanan: ",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${pesan.kodePemesanan}",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${pesan.status}",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: 
                              pesan.status == "Belum Bayar" ? const Color(0xFFE53935) :
                              pesan.status == "Sudah Bayar" ? Color(0xFF43A047) : Color(0xFF757575)
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Tanggal Pemesanan: ${pesan.tanggal}"),
                      SizedBox(height: 10),
                      Text("Daftar Pesanan: "),
                      isLoadingPesanKeranjang
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                              children: keranjangPesan.map<Widget>((cart) => Card(
                                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset("assets/logo/logo_background.png", width: 70),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cart.namaProduk,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${cart.kategori} - ${cart.grup}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              'x${cart.jumlah} = ${cart.hargaTotal}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )).toList(),
                            ),
                      SizedBox(height: 20,),
                      
                    ],
                  )
                ),
                
              ],
            ),
            if (popupBayar)
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: popupBayar ? 0.5 : 0.0,
              child: 
              GestureDetector(
                onTap: () {
                  setState(() {
                    popupBayar = false;
                  });
                },
                child: 
                  Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: double.infinity,
                  ),
              )
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              bottom: popupBayar ? 0 : -300,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: popupBayar ? 1.0 : 0.0,
                child: 
                
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black26,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child:
                  ListView(
                    children: [

                      Stack(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Upload Bukti Pembayaran: ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                gambar == null ? 
                                Center(
                                  child: 
                                  ElevatedButton(
                                    onPressed: (){
                                      pickImage(context, () {
                                        setState(() {});
                                      });
                                    },
                                    style: 
                                    ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff93AABF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        
                                      ),
                                      
                                    ),
                                    child: Text('Pilih Gambar', style: TextStyle(color: Colors.white),),
                                  ),
                                )
                                :
                                GestureDetector(
                                  onTap:(){
                                      pickImage(context, () {
                                        setState(() {});
                                      });
                                    },
                                  child:
                                  Column(
                                    children: [
                                      Center(
                                        child: 
                                          Container(
                                            height: 300,
                                            width: 300,
                                            child: Image.file(gambar!, fit: BoxFit.cover,),
                                          ),
                                      ),
                                      Text("Tap gambar untuk mengganti gambar"),
                                    ],
                                  )
                                ),
                                SizedBox(height: 10),
                                
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
            ),

            // if (!popupBayar)
            
            if (popupBatal)
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: popupBatal ? 0.5 : 0.0,
              child: 
              GestureDetector(
                onTap: () {
                  setState(() {
                    popupBatal = false;
                  });
                },
                child: 
                  Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: double.infinity,
                  ),
              )
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              bottom: popupBatal ? 0 : -300,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: popupBatal ? 1.0 : 0.0,
                child: 
                
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black26,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child:
                  ListView(
                    children: [

                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 2,
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text('Ingin Mengubah Produk'),
                                        onTap: () {
                                          catatan.text = "Ingin Mengubah Produk";
                                        },
                                      ),
                                      Divider(height: 1),
                                      ListTile(
                                        title: Text('Ingin Membatalkan Pesanan'),
                                        onTap: () {
                                          catatan.text = "Ingin Membatalkan Pesanan";
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Catatan:',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: catatan,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: 'Tulis catatan di sini...',
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: const EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:

                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black26,
                        offset: Offset(0, 4),
                      ),
                    ],
                    
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 10, left: 10),
                        child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                  "TOTAL:", 
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${pesan.hargaTotal}", 
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        
                      ),
                      SizedBox(height: 10,),
                      pesan.status == "Belum Bayar" ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: 
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                shadowColor: Colors.transparent,
                                backgroundColor: const Color.fromARGB(255, 230, 230, 230)
                              ),
                              onPressed: procesBatal ? (){} : procesBayar ? (){} : (){
                                popupBatal ? 
                                batalkanPesanan(context, (){setState(() {});}, pesan.idPesan, catatan.text)
                                // print("hai")
                                :
                                setState(() {
                                  popupBayar = false;
                                  popupBatal = !popupBatal;
                                });
                              },
                              child:
                              procesBayar ? CircularProgressIndicator(color: const Color(0xFFFDD835),) :  procesBatal ? CircularProgressIndicator(color: const Color(0xFFFDD835),) :
                                Text('Batalkan Pesanan', style: TextStyle(color: Colors.black),)
                            )
                          ),
                          SizedBox(width: 15,),
                          Expanded(child: 
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50), // Lebar dan tinggi
                                shadowColor: Colors.transparent,
                                backgroundColor: const Color(0xFFE53935)
                              ),
                              onPressed: procesBayar ? (){} : procesBatal ? (){} : (){
                                popupBayar ?
                                bayarPesanan(context, (){setState(() {});}, pesan.idPesan)
                                :
                                setState(() {
                                  popupBatal = false;
                                  popupBayar = !popupBayar;
                                });
                              },
                              child:
                                procesBayar ? CircularProgressIndicator(color: const Color(0xFFFDD835),) :  procesBatal ? CircularProgressIndicator(color: const Color(0xFFFDD835),) :
                                Text('Bayar',style: TextStyle(color: const Color(0xFFFDD835)),)
                            )
                          ),
                        ],
                      )
                      :
                      Center(
                        child: Text(
                          "${pesan.status}",
                          style: TextStyle(
                            color: 
                            pesan.status == "Batal" ? const Color(0xFFE53935) :  const Color(0xFF43A047),
                            
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                )
            )
            

          ],
        )

      );
    
  }
}