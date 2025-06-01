import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pemesanandk/misc/additional.dart';
import 'package:pemesanandk/pages/cart/backend/cart.dart';
import 'package:pemesanandk/pages/cart/model/SelectedCartModel.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Cart();
  }
}

class _Cart extends StatefulWidget {
  const _Cart({super.key});

  @override
  State<_Cart> createState() => __CartState();
}

class __CartState extends State<_Cart> {
  @override
  void initState() {
    super.initState();
    getCart(context, () {
      setState(() {});
    });
  }
  Future<void> _handleRefresh() async {
    // Simulasi delay 2 detik (misal ambil data dari API)
    await Future.delayed(Duration(seconds: 2));

    // Jalankan logika yang ingin kamu lakukan, misalnya fetch data baru
    setState(() {
      getCart(context, () {
        setState(() {});
      });
    });
  }


  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: 
      Stack(
        children: [
          Column(
            children: [
              Expanded(child: 
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Stack(
                    children: [
                      isLoadingCart ?  Center(child: CircularProgressIndicator(color: const Color(0xFFE53935),)) : 
                      isEmptyCart ?  Center(child: Text('Keranjang Kosong'),) : 
                      RefreshIndicator(
                        color: const Color(0xFFE53935),
                        onRefresh: _handleRefresh,
                        child: 
                        ListView.builder(
                          itemCount: carts.length,
                          itemBuilder: (context, index){
                            var cart = carts[index];
                            return
                            GestureDetector(
                              onTap: () {
                                  SelectedCartModel selected = SelectedCartModel(
                                    keranjangId: cart.keranjangId,
                                    userId: cart.userId,
                                    hargaTotal: cart.hargaTotal,
                                    hargaraw: cart.hargaraw,
                                    jumlah: cart.jumlah,
                                    namaProduk: cart.namaProduk,
                                    satuan: cart.satuan,
                                    kategori: cart.kategori,
                                    grup: cart.grup,
                                    stok: cart.stok,
                                    hargaMitra: cart.hargaMitra,
                                  );
                                  setState(() {
                                    showPopup = !showPopup;
                                    selectedItem.add(selected);
                                    // jumlahs = cart.jumlah;
                                    jumlahController.text = cart.jumlah.toString();
                                    total = total;
                                  });
                                  print(cart.hargaTotal);
                                  print(cart.hargaraw);
                                  print(cart.jumlah);
                                },
                              child: 
                              Card(
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
                                          child: Image.asset("assets/logo/logo_background.png", width: 70,)
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
                                              // SizedBox(height: 8),
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
                                          )       
                                        ),
                                        
                                      ],
                                    ),
                                  )
                              )
                              
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(!showPopup)
              Padding(
                padding: EdgeInsets.only(
                  bottom: 0,
                ),
                child: 
                  Align(
                    child: 
                    Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: EdgeInsets.only(

                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      
                      
                    ),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEmptyCart ?"TOTAL: -" :
                          "TOTAL: ${formatRupiah(totalHarga)}",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                          
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(50, 50), // Lebar dan tinggi
                            shadowColor: Colors.transparent,
                            backgroundColor: const Color(0xFFE53935)
                          ),
                          onPressed: isEmptyCart ? (){toastgagal(context, "Keranjang Kosong!", false);} : () {
                            FocusScope.of(context).unfocus();
                            addPesanan(context, (){setState(() {});});
                          },
                          child:Text('Checkout',style: TextStyle(color: const Color(0xFFFDD835)),),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ],
          ),
          if (showPopup)
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: showPopup ? 0.5 : 0.0,
              child: 
              GestureDetector(
                onTap: () {
                  setState(() {
                    showPopup = false;
                    selectedItem = [];
                    total = "0";
                    jumlahs = "0";
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
              bottom: showPopup ? 0 : -300,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: showPopup ? 1.0 : 0.0,
                
                child: 
                
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
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
                  ListView.builder(
                      itemCount: selectedItem.length,

                      itemBuilder: (context, index) {
                      var sel = selectedItem[index];
                      return

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Center(
                            child: 
                            Text('${sel.namaProduk}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),
                          Center(
                            child: 
                            Text('${formatRupiah(sel.hargaMitra)}/${sel.satuan}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Stok: ${sel.stok}'),
                              Text('Total: ${formatRupiah(total).toString()}'),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(child: 
                                ElevatedButton(
                                  onPressed: () {
                                    jumlahController.text = (int.parse(jumlahController.text)-1).toString();
                                    setState(() {
                                      total = (int.parse(sel.hargaMitra) * int.parse(jumlahController.text)).toString();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20), // Ukuran button
                                    backgroundColor: const Color.from(alpha: 1, red: 0.878, green: 0.878, blue: 0.878), // Warna button
                                  ),
                                  child: const Icon(Icons.remove, color: const Color(0xFF212121)),
                                )
                              ),
                              Expanded(child: 
                                TextField(
                                  controller: jumlahController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      total = (int.parse(sel.hargaMitra) * int.parse(jumlahController.text)).toString();
                                    });
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "jumlah",
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: 
                                ElevatedButton(
                                  onPressed: () {
                                    jumlahController.text = (int.parse(jumlahController.text)+1).toString();
                                    setState(() {
                                      total = (int.parse(sel.hargaMitra) * int.parse(jumlahController.text)).toString();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20), // Ukuran button
                                    backgroundColor: const Color.from(alpha: 1, red: 0.878, green: 0.878, blue: 0.878), // Warna button
                                  ),
                                  child: const Icon(Icons.add, color: const Color(0xFF212121)),
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: Row(
                              children: [
                                Expanded(child: 
                                  ElevatedButton(
                                    style: 
                                    ElevatedButton.styleFrom(
                                      minimumSize: Size(200, 50), // Lebar dan tinggi
                                      shadowColor: Colors.transparent,
                                      backgroundColor: const Color.fromARGB(255, 230, 230, 230)
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      deleteCart(context, (){setState(() {});}, sel.keranjangId);
                                      
                                    },
                                    child: Text('Hapus', style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                                Expanded(child: 
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(200, 50), // Lebar dan tinggi
                                      shadowColor: Colors.transparent,
                                      backgroundColor: const Color(0xFFE53935)
                                    ),
                                    onPressed: processedEdit ? null : () {
                                      FocusScope.of(context).unfocus();
                                      updateCart(context, (){setState(() {});}, sel.keranjangId, jumlahController.text);
                                    },
                                    child:processedEdit? CircularProgressIndicator() : Text('Update',style: TextStyle(color: const Color(0xFFFDD835)),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );}
                  )
                ),
              ),
            ),
            if (successKeranjang)
            Visibility(
              visible: successKeranjang,
              child: 
              Padding(
                padding: EdgeInsets.only(
                  bottom: 90,
                ),
                child: 
                Align(
                  alignment: Alignment.bottomCenter,
                  child: 
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 20,
                      right: 20,
                      top: 10,

                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Item berhasil diedit"),
                        Icon(Icons.check_circle_sharp, color: const Color.fromARGB(255, 53, 229, 112),),
                      ],
                    )
                  ),
                ),
              ),
            ),
            if (successDeleteKeranjang)
            Visibility(
              visible: successDeleteKeranjang,
              child: 
              Padding(
                padding: EdgeInsets.only(
                  bottom: 90,
                ),
                child: 
                Align(
                  alignment: Alignment.bottomCenter,
                  child: 
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 20,
                      right: 20,
                      top: 10,

                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Item berhasil dihapus"),
                        Icon(Icons.check_circle_sharp, color: const Color.fromARGB(255, 53, 229, 112),),
                      ],
                    )
                  ),
                ),
              ),
            ),
            if (errorKeranjang)
            Visibility(
              visible: errorKeranjang,
              child: 
              Padding(
                padding: EdgeInsets.only(
                  bottom: 80,
                ),
                child: 
                Align(
                  alignment: Alignment.bottomCenter,
                  child: 
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 20,
                      right: 20,
                      top: 10,

                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Terjadi kesalahan, coba lagi"),
                        Icon(Icons.close_rounded, color: const Color(0xFFE53935),),
                      ],
                    )
                  ),
                ),
              ),
            ),

            
        ],
      )
    );
  }
}