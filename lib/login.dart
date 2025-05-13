import 'package:appekrili/homepage.dart';
import 'package:appekrili/signup.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (email.isEmpty || !email.contains('@')) {
      setState(() => _emailError = 'Please enter a valid email.');
      return;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = 'Please enter your password.');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Login error: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found') {
        setState(() => _emailError = 'No account found for this email.');
        _showErrorDialog('No account found for this email.');
      } else if (e.code == 'wrong-password') {
        setState(() => _passwordError = 'Incorrect password.');
        _showErrorDialog('Incorrect password.');
      } else {
        _showErrorDialog(e.message ?? 'Login failed.');
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      _showErrorDialog('Something went wrong. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _emailError = 'Please enter a valid email to reset password.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success',
        desc: 'Password reset email sent!',
        btnOkOnPress: () {},
      ).show();
    } on FirebaseAuthException catch (e) {
      debugPrint('Password reset error: ${e.message}');
      _showErrorDialog(e.message ?? 'Failed to send reset email.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  height: 25,
                  child: Text(
                    'Welcome to Ekrili',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'images/Ekrili logo.png',
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Connect to Your Account",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.white),
                    errorText: _emailError,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white),
                    errorText: _passwordError,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _resetPassword,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    "Connect",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
