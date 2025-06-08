import 'package:flutter/material.dart';
import 'package:pemesanandk/auth/auth.dart';
import 'package:pemesanandk/misc/misc.dart';
import 'package:pemesanandk/pages/profile/reset_password.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Profile();
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProfile(context, (){setState(() {
      
    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
      Container(
        child: 
        ListView(
          children: [

            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          
                          child: CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFFFDD835),
                          child: Text(
                            nama?[0].toUpperCase() ?? 'M',
                            style: TextStyle(fontSize: 40.0, color: const Color(0xFFE53935)),
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: 15),
                    Text(
                      nama ?? "Mitra Dkriuk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      kode ?? "Mitra Dkriuk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Expanded( // agar Text bisa melar dan wrap
                            child: Text(
                              'Summary',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag, color: const Color(0xFFE53935),),
                      title: Row(
                        children: [
                          Text('$stokis', 
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 15,
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
                                fontSize: 15,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: const Color(0xFFE53935),),
                      title: Row(
                        children: [
                          Expanded( // agar Text bisa melar dan wrap
                            child: Text(
                              '$nomor',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 15,
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
                    SizedBox(height: 5, child: Container(color: const Color.fromARGB(255, 222, 222, 222),),),
                    ListTile(
                      title: Row(
                        children: [
                          Expanded( // agar Text bisa melar dan wrap
                            child: Text(
                              'Akun',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.password, color: const Color(0xFFE53935),),
                      onTap: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => ResetPassword()));
                      },
                      title: Row(
                        children: [
                          Expanded( // agar Text bisa melar dan wrap
                            child: Text(
                              'Ubah Password',
                              style: TextStyle(decoration: TextDecoration.none),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: const Color(0xFFE53935),),
                      onTap: () => logout(context),
                      title: Row(
                        children: [
                          Expanded( // agar Text bisa melar dan wrap
                            child: Text(
                              'Logout',
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
              ],
            )
          ],
        )
      )
    );
  }
}