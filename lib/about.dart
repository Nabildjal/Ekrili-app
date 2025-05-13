import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45), // Keep theme color
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: const Color(0xFF0A0A45),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 20),

            // 🔹 App Name & Version in a Card
            Card(
              color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Ekrili App",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Version 1.0.0",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 App Description
            const Text(
              "Ekrili App is a platform that allows users to browse and rent machines efficiently. "
              "Our mission is to make industrial and warehouse equipment easily accessible, ensuring "
              "a smooth and hassle-free rental experience.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
            ),

            const SizedBox(height: 30),

            // 🔹 Contact Information Section
            Card(
              color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.email, color: Colors.orangeAccent),
                        SizedBox(width: 8),
                        Text("support@ekrili.com", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.language, color: Colors.orangeAccent),
                        SizedBox(width: 8),
                        Text("www.ekrili.com", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Return to Settings Button
            TextButton.icon(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text("Back to Settings", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
