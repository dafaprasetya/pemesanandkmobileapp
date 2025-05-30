import 'package:flutter/material.dart';
import 'package:pemesanandk/auth/auth.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:pemesanandk/pages/cart/keranjang_page.dart';
import 'package:pemesanandk/pages/order/pesanan_page.dart';
import 'package:pemesanandk/pages/shop/shop_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return HPage();
  }
}

class HPage extends StatefulWidget {
  const HPage({super.key});

  @override
  State<HPage> createState() => _HPageState();
}

class _HPageState extends State<HPage> {
  @override
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProfile(context, () {
      setState(() {});
    });
  }
  final List<Widget> _pages = [
    ShopPage(),
    CartPage(),
    OrderPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _geser(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // supaya AppBar transparan
      
      body: PageView(
        controller: _pageController,
        // physics: NeverScrollableScrollPhysics(),
        onPageChanged: _geser,
        children: _pages,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(nama ?? 'Nama Mitra'),
                  accountEmail: Text(kode ?? 'Kode Mitra'),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 136, 136, 136)
                ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      nama?[0].toUpperCase() ?? 'M',
                      style: TextStyle(fontSize: 40.0, color: Colors.blue),
                    ),
                  ),
                ),
                Expanded(child: 
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Row(
                          children: [
                            Text('$stokis', style: TextStyle(decoration: TextDecoration.none),),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Row(
                          children: [
                            Expanded( // agar Text bisa melar dan wrap
                              child: Text(
                                '$alamat',
                                style: TextStyle(decoration: TextDecoration.none),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.supervised_user_circle),
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
                    backgroundColor: const Color.fromARGB(255, 136, 136, 136),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFE53935),
        unselectedItemColor: Colors.grey,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Daftar Pesanan',
          ),
      ]),
    );
  }
}