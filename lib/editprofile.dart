import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  TextEditingController nameController = TextEditingController(text: "Ahmed");
  TextEditingController emailController = TextEditingController(text: "brahimiah@example.com");
  TextEditingController phoneController = TextEditingController(text: "+213 550 55 33 80");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45), // Match app theme
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF0A0A45),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // ✅ Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF0A0A45)),
              ),
              TextButton.icon(
                onPressed: () {
                  // Add function to change profile picture
                },
                icon: const Icon(Icons.camera_alt, color: Colors.orangeAccent),
                label: const Text("Change Photo", style: TextStyle(color: Colors.orangeAccent)),
              ),
              
              const SizedBox(height: 20),
              
              // ✅ Editable Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Full Name", nameController, Icons.person),
                    const SizedBox(height: 10),
                    _buildTextField("Email", emailController, Icons.email),
                    const SizedBox(height: 10),
                    _buildTextField("Phone Number", phoneController, Icons.phone),
                    const SizedBox(height: 30),

                    // ✅ Save Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save changes logic here
                          Navigator.pop(context);
                          
                        }
                      },
                      child: const Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    
                    const SizedBox(height: 10),

                    // ✅ Cancel Button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel", style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method for TextFields
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1A1A5A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) => value!.isEmpty ? "$label cannot be empty" : null,
    );
  }
}
