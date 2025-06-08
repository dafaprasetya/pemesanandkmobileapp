import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pemesanandk/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pemesanandk/misc/misc.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return LPages();
  }
  
}

class LPages extends StatefulWidget {
  const LPages({super.key});

  @override
  State<LPages> createState() => _LPagesState();
}

class _LPagesState extends State<LPages> {
  
  @override
  void initState() {
    super.initState();
  }
  


  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: 
      Container(
        child: 
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              // color: Color(0xFF1F5B85),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [const Color.fromARGB(255, 255, 0, 0), const Color.fromARGB(255, 255, 35, 35)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              child: Center(
                child: Image.asset("assets/logo/logo.png", width: 100,),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: 
                ListView(

                    padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          child: Lottie.asset('assets/lottie/market.json'),
                        ),
                        SizedBox(height: 20,),
                        Text("Pemesanan bahan baku dkriuk",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 33, 33, 33), 
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Silahkan login untuk melanjutkan",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 33, 33, 33), 
                            fontSize: 10,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Material(
                          child:
                          Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child:
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Kode Mitra",
                                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Material(
                          child:
                          Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child:
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.key, color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: 
                            SizedBox(
                              
                              height: 50,
                              width: double.infinity,
                              child: 
                                ElevatedButton(
                                  onPressed: () => login(context), 
                                  
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      
                                    ),
                                    
                                  ),
                                  child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 15,),),
                                )
                            ),
                        ),
                        SizedBox(height: 60,),
                        Text(
                          "V $app_version",
                          style: TextStyle(
                            fontSize: 10,
                            color: const Color.fromARGB(115, 0, 0, 0),
                            decoration: TextDecoration.none
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
          ],
        )
      )
    );
  }

}