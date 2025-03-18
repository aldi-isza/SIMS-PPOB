import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sims_ppob/data/models/user_registration_model.dart'; // Import model
import 'package:sims_ppob/presentation/pages/dashboard_page.dart';
import '../widgets/widgets.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk menangkap input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false; // Untuk menampilkan loading

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengirim data registrasi ke API
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true); // Tampilkan loading

    UserRegistration user = UserRegistration(
      email: _emailController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      password: _passwordController.text,
    );

    final response = await http.post(
      Uri.parse('https://take-home-test-api.nutech-integrasi.com/registration'),
      headers: {'Content-Type': 'application/json'},
      body: userRegistrationToJson(user),
    );

    setState(() => _isLoading = false); // Sembunyikan loading

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _showSnackBar(
        "Registrasi berhasil: ${responseData['message']}",
        Colors.green,
      );

      // Navigasi ke DashboardPage setelah sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      final errorData = json.decode(response.body);
      _showSnackBar("Registrasi gagal: ${errorData['message']}", Colors.red);
    }
  }

  // Menampilkan SnackBar untuk notifikasi
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Logo.png', height: 30, width: 30),
                      const Gap(8),
                      const Text(
                        'SIMS PPOB',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),
                  const Text(
                    'Lengkapi data untuk membuat akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                      height: 1.2,
                    ),
                  ),
                  const Gap(52),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Masukkan email Anda',
                    prefixIcon: Icons.alternate_email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(12),
                  CustomTextField(
                    controller: _firstNameController,
                    hintText: 'Nama depan',
                    prefixIcon: Icons.person_outline,
                  ),
                  const Gap(12),
                  CustomTextField(
                    controller: _lastNameController,
                    hintText: 'Nama belakang',
                    prefixIcon: Icons.person_outline,
                  ),
                  const Gap(12),
                  CustomTextFieldPass(
                    controller: _passwordController,
                    text: 'Masukkan password Anda',
                  ),
                  const Gap(12),
                  CustomTextFieldPass(
                    controller: _confirmPasswordController,
                    text: 'Konfirmasi password Anda',
                    validator:
                        (value) =>
                            value != _passwordController.text
                                ? 'Password tidak sama'
                                : null,
                  ),
                  const Gap(52),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                        text: 'Registrasi',
                        color: Colors.red,
                        onPressed: _register, // Panggil fungsi register
                        colorText: Colors.white,
                      ),
                  const Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? login'),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          ' di sini',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
