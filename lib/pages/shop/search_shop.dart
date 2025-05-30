import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:pemesanandk/pages/shop/backend/shop.dart';
import 'package:pemesanandk/pages/shop/model/SelectedProduct.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class SearchShopPage extends StatelessWidget {
  const SearchShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SearchShop();
  }
}

class _SearchShop extends StatefulWidget {
  const _SearchShop({super.key});

  @override
  State<_SearchShop> createState() => __SearchShopState();
}

class __SearchShopState extends State<_SearchShop> {
  
  @override
  
  void initState() {
    super.initState();
    prodSearchEmpty = false;
    isloadingProdSearch= !isloadingProdSearch; 

    // productSearch = [];
    getProductSearch(context, () {
      setState(() {});
    });
    
  }
  bool showNotif = false;

  void showTemporaryNotif() {
    setState(() {
      showNotif = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showNotif = false;
      });
    });
  }
  bool _showPopup = false;
  // List<SelectedProduct> selectedItem = [];
  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getProductSearch(context, () {
        setState(() {});
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                
                child: TextField(
                  controller: searchController,
                    onSubmitted: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchShopPage()),
                      );
                    },
                  decoration: InputDecoration(
                    hintText: 'Hasil Pencarian ${searchController.text}',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => SearchShopPage()),
                );
              },
              child: const Text('Cari', style: TextStyle(color: Colors.blue)),
            ),
          ],
        )
      ),
      
      body: 
      Stack(
        children: [
          Padding( 
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child:
            isloadingProduct ? CircularProgressIndicator() : 
            Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    prodSearchEmpty ? Align(alignment: Alignment.center, child: Text('Produk Tidak Ditemukan'),) : 
                    
                    Expanded(child: 
                    RefreshIndicator(onRefresh: _handleRefresh, 
                    child: 
                    GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,          // Jumlah kolom = 2
                        crossAxisSpacing: 10,       // Jarak antar kolom
                        mainAxisSpacing: 10,        // Jarak antar baris
                        childAspectRatio: 4 / 5,    // Rasio lebar:tinggi
                      ),
                      itemCount: productSearch.length,
                      itemBuilder: (context, index) {
                      var prod = productSearch[index];
                      return
                      GestureDetector(
                        onTap: () {
                          SelectedProduct selected = SelectedProduct(
                            id: prod.id,
                            namaProduk: prod.namaProduk,
                            harga: prod.harga,
                            hargaraw: prod.hargaraw,
                            stok: prod.stok,
                            satuan: prod.satuan,
                          );
                          setState(() {
                            _showPopup = !_showPopup;
                            selectedItem.add(selected);
                          });
                        },
                        child: 
                        Card(
                          child: Padding(
                          padding:  EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: 
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset("assets/logo/logo_background.png", width: 60,)
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                '${prod.namaProduk}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                                ),
                              ),
                              Text(
                                '${prod.harga}/${prod.satuan}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:  const Color(0xFFE53935),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                                ),
                              ),
                              Text(
                                'Stok: ${prod.stok}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.none
                                ),
                              ),
                              Text(
                                '${prod.kategori} - ${prod.grup}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.none
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        )
                      );

                      }
                      
                    ))
                    )
                  ],
                ),
              ),
            ],
            
          )
          ),
          if (_showPopup)
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _showPopup ? 0.5 : 0.0,
            child: 
            GestureDetector(
              onTap: () {
                setState(() {
                  _showPopup = false;
                  selectedItem = [];
                  total = '0';
                  jumlahController.text = '0';
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
            bottom: _showPopup ? 0 : -300,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _showPopup ? 1.0 : 0.0,
              
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
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
                    var prod = selectedItem[index];
                    return

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Center(
                          child: 
                          Text('${prod.namaProduk}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                        Center(
                          child: 
                          Text('${prod.harga}/${prod.satuan}',
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
                            
                            Text('Stok: ${prod.stok}'),
                            Text('Total: ${formatRupiah(total)}'),

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
                                    total = (int.parse(total) - int.parse(prod.hargaraw)).toString();
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
                                    total = (int.parse(jumlahController.text) * int.parse(prod.hargaraw)).toString();
                                  });
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  hintText: "Jumlah",
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
                                    total = (int.parse(prod.hargaraw) * int.parse(jumlahController.text)).toString();
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
                                    setState(() {
                                      _showPopup = false;
                                      selectedItem = [];
                                      jumlahController.text = '0';
                                      total = '0';
                                    });
                                    
                                  },
                                  child: Text('Batal', style: TextStyle(color: Colors.black),),
                                ),
                              ),
                              Expanded(child: 
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(200, 50), // Lebar dan tinggi
                                    shadowColor: Colors.transparent,
                                    backgroundColor: const Color(0xFFE53935)
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      _showPopup = false;
                                      selectedItem = [];
                                      total = '0';
                                      jumlahController.text = '0';
                                    });
                                  },
                                  child: Text('Tambah',style: TextStyle(color: const Color(0xFFFDD835)),),
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
                bottom: 20,
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
                      Text("Produk ditambahkan ke keranjang"),
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
                bottom: 20,
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
      ),
    );
  }
}
