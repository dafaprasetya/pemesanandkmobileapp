import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:pemesanandk/pages/shop/model/SelectedProduct.dart';
import 'package:pemesanandk/pages/shop/search_shop.dart';
import 'package:pemesanandk/pages/shop/backend/shop.dart';
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
  bool _showPopup = false;
  List<SelectedProduct> selectedItems = [];
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    hintText: 'Cari',
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
                    Expanded(child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                      var prod = products[index];
                      return
                        Card(
                          child: Padding(
                          padding:  EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset("assets/logo/logo.png", width: 100,)
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${prod.namaProduk}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Harga: Rp. ${prod.harga}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        decoration: TextDecoration.none
                                      ),
                                    ),
                                    Text(
                                      'Stok: ${prod.stok}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        decoration: TextDecoration.none
                                      ),
                                    ),
                                    Center(
                                      child: 
                                      ElevatedButton(
                                        onPressed: (){
                                          SelectedProduct selected = SelectedProduct(
                                            id: prod.id,
                                            namaProduk: prod.namaProduk,
                                            harga: prod.harga,
                                            stok: prod.stok,
                                          );
                                          setState(() {
                                            _showPopup = !_showPopup;
                                            selectedItems.add(selected);
                                          });
                                          
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 136, 136, 136),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          minimumSize: Size(200,30)
                                        ),
                                        child: Text('Tambah ke keranjang', style: TextStyle(color: Colors.white, fontSize: 15,),),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        );

                      }
                      
                    )
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
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
            ),
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
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                    var prod = selectedItems[index];
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
                        SizedBox(height: 12),
                        Text('stok: ${prod.stok}'),
                        SizedBox(height: 6),
                        Text('harga: ${prod.harga}'),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(child: 
                              ElevatedButton(
                                onPressed: () {
                                  jumlahController.text = (int.parse(jumlahController.text)-1).toString();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20), // Ukuran button
                                  backgroundColor: const Color.fromARGB(255, 136, 136, 136), // Warna button
                                ),
                                child: const Icon(Icons.remove, color: Colors.white),
                              )
                            ),
                            Expanded(child: 
                              TextField(
                                controller: jumlahController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  hintText: "Masukan jumlah yang ingin dimasukan ke keranjang",
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
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20), // Ukuran button
                                  backgroundColor: const Color.fromARGB(255, 136, 136, 136), // Warna button
                                ),
                                child: const Icon(Icons.add, color: Colors.white),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: Row(
                            children: [
                              Expanded(child: 
                                ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      _showPopup = false;
                                      selectedItems = [];
                                    });
                                  },
                                  child: Text('Batal'),
                                ),
                              ),
                              Expanded(child: 
                                ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      _showPopup = false;
                                    });
                                  },
                                  child: Text('Tambah'),
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
        ],
      ),
    );
  }
}