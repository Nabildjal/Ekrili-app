import 'package:appekrili/homepage.dart';
import 'package:appekrili/login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSendingVerification = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        setState(() => _isSendingVerification = true);
        await user.sendEmailVerification();
        setState(() => _isSendingVerification = false);

        _showVerificationDialog(user);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Home()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Signup Failed',
        desc: errorMessage,
      ).show();
    }
  }

  void _showVerificationDialog(User user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Verify Your Email"),
        content: const Text(
            "We've sent you a verification link. Please check your inbox (and spam folder)."),
        actions: [
          TextButton(
            onPressed: () async {
              await user.reload();
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Email not verified yet."),
                  ),
                );
              }
            },
            child: const Text("Check Again"),
          ),
          TextButton(
            onPressed: () async {
              await user.sendEmailVerification();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Verification email resent."),
                ),
              );
            },
            child: const Text("Resend Email"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create Account",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: _usernameController,
                label: "Username",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _passwordController,
                label: "Password",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: _isSendingVerification ? null : _signUp,
                child: Text(
                  _isSendingVerification ? "Sending..." : "Sign Up",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0A0A45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
