import 'package:appekrili/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45), // Matching app theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A45),
        elevation: 0,
        title: const Text("Logout", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.exit_to_app, size: 80, color: Colors.redAccent),
              const SizedBox(height: 20),
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Logout Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
               
                  // Perform logout logic (clear session, navigate to login)
                  onPressed: (){
                 Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
              
                },
                child: const Text("Logout", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              
              const SizedBox(height: 10),

              // Cancel Button
              TextButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();// Return to previous page
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
                },
                child: const Text("Cancel", style: TextStyle(fontSize: 16, color: Colors.orangeAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
