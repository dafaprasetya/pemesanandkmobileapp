import 'package:flutter/material.dart';
import 'package:pemesanandk/pages/profile/backend/profile.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Passowrd();
  }
}

class Passowrd extends StatefulWidget {
  const Passowrd({super.key});

  @override
  State<Passowrd> createState() => _PassowrdState();
}

class _PassowrdState extends State<Passowrd> {
  @override
  @override

  Future<void> confirmPassword(BuildContext context, VoidCallback onSuccess) async {
    final password = passwordRController.text;
    final confirm = confirmPRController.text;
    if (confirm.isEmpty) {
      errorText = null;
      onSuccess();
    } else if (confirm != password) {
      errorText = 'Konfirmasi password tidak cocok';
      onSuccess();
    } else {
      errorText = null;
      onSuccess();
    }
      onSuccess();
  }

  void initState() {
    super.initState();
    
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
      Padding(padding: EdgeInsets.symmetric(horizontal: 20),
        child: 
          Column(
            children: [
              Center(child: Text("Reset Password"),),
              ListTile(
                leading: Icon(Icons.key),
                title: TextFormField(
                  controller: oldpasswordRController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password Lama',
                    // errorText: errorText,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              ListTile(
                leading: Icon(Icons.key),
                title: TextFormField(
                  controller: passwordRController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password Baru'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.key),
                title: TextFormField(
                  controller: confirmPRController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password Baru',
                    errorText: errorText,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: processReset ? (){} : () {
                  confirmPassword(context, (){setState(() {
                    
                  });});
                  if (errorText == null && passwordRController.text.isNotEmpty && confirmPRController.text.isNotEmpty && oldpasswordRController.text.isNotEmpty) {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password cocok!')),
                    );
                    resetPassword(context, (){setState(() {});}, oldpasswordRController.text, passwordRController.text);
                  } else {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password tidak cocok')),
                    );
                  }
                },
                child: processReset ? CircularProgressIndicator() : Text('Submit'),
              )
              
              
            ],
          ),

      )
    );
  }
}