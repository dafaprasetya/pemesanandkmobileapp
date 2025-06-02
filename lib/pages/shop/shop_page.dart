import 'package:flutter/material.dart';
import 'package:pemesanandk/auth/auth.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:pemesanandk/pages/profile/profile_page.dart';
import 'package:pemesanandk/pages/shop/model/SelectedProduct.dart';
import 'package:pemesanandk/pages/shop/search_shop.dart';
import 'package:pemesanandk/pages/shop/backend/shop.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shop();
  }
}

class _Shop extends StatefulWidget {
  const _Shop({super.key});

  @override
  State<_Shop> createState() => __ShopState();
}

class __ShopState extends State<_Shop> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct(context, () {
      setState(() {});
    });
    // getProduct(context)
  }

  
  // List<SelectedProduct> selectedItem = [];
  
  Future<void> _handleRefresh() async {
    // Simulasi delay 2 detik (misal ambil data dari API)
    await Future.delayed(Duration(seconds: 2));

    // Jalankan logika yang ingin kamu lakukan, misalnya fetch data baru
    setState(() {
      getProduct(context, () {
        setState(() {});
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: 
                      TextField(
                        controller: searchController,
                          onSubmitted: (value) {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => SearchShopPage()),
                            );
                          },
                        decoration: InputDecoration(
                          hintText: 'Cari',
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
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
                      child: const Text('Cari', style: TextStyle(color: const Color(0xFFE53935))),
                    ),
                  ],
                )
              ),
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
            isloadingProduct ? Center(child:CircularProgressIndicator(color: const Color(0xFFE53935),)) : 
            Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: 
                    RefreshIndicator(
                      color: const Color(0xFFE53935),
                      onRefresh: _handleRefresh, 
                    child: 
                    GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,          // Jumlah kolom = 2
                        crossAxisSpacing: 0,       // Jarak antar kolom
                        mainAxisSpacing: 0,        // Jarak antar baris
                        childAspectRatio: 4 / 5,    // Rasio lebar:tinggi
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                      var prod = products[index];
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
                            showPopup = !showPopup;
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
                              SizedBox(height: 6),
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
            bottom: showPopup ? 0 : -300,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: showPopup ? 1.0 : 0.0,
              
              child: 
              
              Container(
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
                                      showPopup = false;
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
                                   

                                  onPressed: processedKeranjang ? null : () {
                                    FocusScope.of(context).unfocus();
                                    addToCart(context, (){setState(() {});}, prod.id, jumlahController.text);
                                    
                                    
                                  },
                                  child: processedKeranjang ? CircularProgressIndicator() : Text('Tambah',style: TextStyle(color: const Color(0xFFFDD835)),),
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
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
          ),
        ),
        backgroundColor: const Color(0xFFFAFAFA),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(nama ?? 'Nama Mitra'),
                  accountEmail: Text(kode ?? 'Kode Mitra'),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935)
                ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: const Color(0xFFFDD835),
                    child: Text(
                      nama?[0].toUpperCase() ?? 'M',
                      style: TextStyle(fontSize: 40.0, color: const Color(0xFFE53935)),
                    ),
                  ),
                ),
                Expanded(child: 
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: Icon(Icons.shopping_bag, color: const Color(0xFFE53935),),
                        title: Row(
                          children: [
                            Text('$stokis', 
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on, color: const Color(0xFFE53935),),
                        title: Row(
                          children: [
                            Expanded( // agar Text bisa melar dan wrap
                              child: Text(
                                '$alamat',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 13,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.supervised_user_circle, color: const Color(0xFFE53935),),
                        title: Row(
                          children: [
                            Expanded( // agar Text bisa melar dan wrap
                              child: Text(
                                '$level',
                                style: TextStyle(decoration: TextDecoration.none),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  )
                )
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: 
              Align(
                alignment: Alignment.bottomLeft,
                
                child: Text('app version = $app_version', 
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none
                  ),
                )
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: 
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () => logout(context), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(180,40)
                  ),
                  child: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 15,),),
                )
              )
            ),
            
          ],
        ),
      ),
    );
    
  }
}