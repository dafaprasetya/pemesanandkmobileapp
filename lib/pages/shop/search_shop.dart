import 'package:flutter/material.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:pemesanandk/pages/shop/backend/shop.dart';

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
      Padding( 
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: 
        Stack(
        children: [
          
        ],
      ))
    );
  }
}