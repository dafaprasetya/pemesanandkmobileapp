import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pemesanandk/auth/auth.dart';

String domain = "http://10.0.2.2/dkriuks";
// String domain = "http://autoreport.dkriuk.com";


void closetoast(value) {
  value = !value;
}

void toastgagal(BuildContext context, pesan, add1) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Menutup dialog
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    iconSize: 30,
                  ),
                  child: Icon(Icons.close),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Lottie.asset('assets/lottie/erroranimation.json'),
              ),
              // SizedBox(height: 10),
              Text(
                pesan,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              if(add1)
              ElevatedButton(onPressed: ()=>logout(context), child: Text('Logout'))


            ],
          ),
        ),
      );
    },
  );
}
void toastloading(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Lottie.asset('assets/lottie/erroranimation.json'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
void toastberhasil(BuildContext context, pesan, add1) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Menutup dialog
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    iconSize: 30,
                  ),
                  child: Icon(Icons.close),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Lottie.asset('assets/lottie/success.json'),
              ),
              // SizedBox(height: 10),
              Text(
                pesan,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              if(add1)
              ElevatedButton(onPressed: ()=>logout(context), child: Text('Logout'))


            ],
          ),
        ),
      );
    },
  );
}