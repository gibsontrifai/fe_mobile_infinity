import 'package:flutter/material.dart';
import 'package:safetyfeapps/screens/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginK3Page extends StatefulWidget {
  const LoginK3Page({super.key});

  @override
  State<LoginK3Page> createState() => _LoginK3PageState();
}

class _LoginK3PageState extends State<LoginK3Page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final bool _bypassBackendLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _login() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   final String email = _emailController.text;
  //   final String password = _passwordController.text;

  //   const String apiUrl = 'http://localhost:8080/v1/api/login'; 

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'username': email, // Menggunakan nilai dari _emailController sebagai username
  //         'password': password,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       // Login berhasil
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);
  //       print('Login successful: ${responseData['token']}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Login Berhasil!')),
  //       );
  //     } else {
  //       final Map<String, dynamic> errorData = jsonDecode(response.body);
  //       print('Login failed: ${errorData['message']}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Login Gagal: ${errorData['message']}')),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error during login: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Terjadi kesalahan: $e')),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  Future<void> _showSuccessAnimation() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 2 * 3.1415926535), 
                duration: const Duration(seconds: 1),
                builder: (context, angle, child) {
                  return Transform.rotate(
                    angle: angle,
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Login Berhasil!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Mengarahkan Anda ke Dashboard...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2)); 
    Navigator.of(context).pop(); 
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true; 
    });

    if (_bypassBackendLogin) {
      await Future.delayed(const Duration(seconds: 1)); 
      await _showSuccessAnimation(); 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      return;
    }

    final String email = _emailController.text;
    final String password = _passwordController.text;

    // const String apiUrl = 'http://localhost:8080/v1/api/login'; // For web testing
    const String apiUrl = 'http://10.0.2.2:8080/v1/api/login'; // For Android emulator

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Login successful: ${responseData['token']}');
        await _showSuccessAnimation(); // Tampilkan animasi sukses
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        print('Login failed: ${errorData['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Gagal: ${errorData['message']}')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8f5e9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 40),
              decoration: const BoxDecoration(
                color: Color(0xff2e7d32),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.engineering,
                    size: 70,
                    color: Colors.yellow,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Safety hub",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "K3 Management System",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "Username",
                  hintText: "Masukkan username",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  hintText: "Masukkan password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                  },
                  child: const Text("Lupa Password?"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Bagian "Or connect with"
            const Text(
              "Or connect with",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            // Tombol login sosial
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Facebook
                GestureDetector(
                  onTap: () {
                    // Aksi untuk login dengan Facebook
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF3b5998), // Warna Facebook
                    child: Icon(Icons.facebook, color: Colors.white, size: 30),
                  ),
                ),
                const SizedBox(width: 20),
                // Tombol Google
                GestureDetector(
                  onTap: () {
                    // Aksi untuk login dengan Google
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage('assets/google_logo.png'),
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Garis pemisah (simulasi garis kuning hitam)
            Container(
              height: 5,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.yellow,
                    Colors.black,
                    Colors.yellow,
                    Colors.black,
                  ],
                  stops: [0.0, 0.2, 0.4, 0.6, 0.8],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue, // Warna link
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Aplikasi Sistem Manajemen K3 | Infinity",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}