import 'dart:io';
import 'package:appekrili/about.dart';
import 'package:appekrili/itemdetails.dart';
import 'package:appekrili/logout.dart';
import 'package:appekrili/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> machines = [];
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    fetchMachines();
  }

  Future<void> fetchMachines() async {
    final snapshot = await FirebaseFirestore.instance.collection('machines').get();
    setState(() {
      machines.clear();
      for (var doc in snapshot.docs) {
        machines.add(doc.data().map((key, value) => MapEntry(key, value.toString())));
      }
    });
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  Future<void> _showAddMachineDialog() async {
    final nameController = TextEditingController();
    final subtitleController = TextEditingController();
    final detailsController = TextEditingController();
    final localisationController = TextEditingController();
    final priceController = TextEditingController();
    final phoneController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1A5A),
        title: Text('Add New Machine', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
              ),
              TextField(controller: nameController, decoration: InputDecoration(hintText: 'Machine Name')),
              TextField(controller: subtitleController, decoration: InputDecoration(hintText: 'Subtitle')),
              TextField(controller: detailsController, decoration: InputDecoration(hintText: 'Details')),
              TextField(controller: localisationController, decoration: InputDecoration(hintText: 'Localisation')),
              TextField(controller: priceController, decoration: InputDecoration(hintText: 'Price')),
              TextField(controller: phoneController, decoration: InputDecoration(hintText: 'Phone Number')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_pickedImage != null && nameController.text.isNotEmpty && subtitleController.text.isNotEmpty) {
                await FirebaseFirestore.instance.collection('machines').add({
                  'name': nameController.text,
                  'subtitle': subtitleController.text,
                  'details': detailsController.text,
                  'Localisation': localisationController.text,
                  'price': priceController.text,
                  'phone': phoneController.text,
                  'image': _pickedImage!.path, // Save local file path
                });

                Navigator.pop(context);
                fetchMachines();
              }
            },
            child: Text('Add Machine'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Ekrili App", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MachineSearch(machines));
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A5A),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(radius: 30, backgroundImage: AssetImage("images/usericon.png")),
                  const SizedBox(height: 10),
                  Text("Welcome, Ahmed", style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("brahimiah@example.com", style: const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, "Home", () => Navigator.pop(context)),
            _buildDrawerItem(Icons.person, "Profile", () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))),
            _buildDrawerItem(Icons.info_outline, "About", () => Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()))),
            const Divider(color: Colors.white30),
            _buildDrawerItem(Icons.logout, "Logout", () => Navigator.push(context, MaterialPageRoute(builder: (context) => LogoutPage()))),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A65),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Colors.white70, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Welcome to Ekrili App! Select a machine to view details.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: machines.length,
                itemBuilder: (context, index) {
                  final imagePath = machines[index]["image"];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemDetailsPage(item: machines[index])),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: imagePath != null
                                  ? Image.file(
                                      File(imagePath),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                                    )
                                  : Icon(Icons.image_not_supported),
                            )//add
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              machines[index]["name"] ?? "",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              machines[index]["subtitle"] ?? "",
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMachineDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}

class MachineSearch extends SearchDelegate {
  final List<Map<String, String>> machines;
  MachineSearch(this.machines);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: Icon(Icons.clear), onPressed: () => query = ""),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchList(context);
  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchList(context);

  Widget _buildSearchList(BuildContext context) {
    final results = machines.where((m) => m["name"]!.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView(
      children: results.map((machine) {
        final imagePath = machine["image"];
        return ListTile(
          leading: imagePath != null
              ? Image.file(
                  File(imagePath),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                )
              : Icon(Icons.image_not_supported),
          title: Text(machine["name"] ?? ""),
          subtitle: Text(machine["subtitle"] ?? ""),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemDetailsPage(item: machine)),
            );
          },
        );
      }).toList(),
    );
  }
}
