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
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFE53935),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFFAFAFA),
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