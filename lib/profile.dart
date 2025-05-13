import 'package:appekrili/editprofile.dart';
import 'package:appekrili/homepage.dart';
import 'package:appekrili/login.dart';
import 'package:flutter/material.dart';
 // Import Home page

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45), // Match app theme
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF0A0A45),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Padding for spacing
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2), // White border
                borderRadius: BorderRadius.circular(10), // Rounded edges
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF0A0A45)),
              ),
              const SizedBox(height: 15),

              // ✅ Name
              Text(
                "Brahimi Ahmed",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),

              // ✅ Email
              Text(
                "brahimiah@gmail.com",
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 10),

              // ✅ Phone Number
              Text(
                "Phone: +213 550 55 33 80",
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              // ✅ Edit Profile Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  // Add navigation to Edit Profile Page
                  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
                },
              ),
              const SizedBox(height: 20),
              
              // ✅ Logout Button
              TextButton.icon(
                icon: const Icon(Icons.exit_to_app, color: Colors.redAccent),
                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
                onPressed: () {
                  // Add logout functionality
                  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
