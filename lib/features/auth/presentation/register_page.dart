import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/features/auth/provider/auth_provider.dart';
import 'package:sims_ppob/presentation/pages/login/login_page.dart';
import 'package:sims_ppob/presentation/widgets/buttons/custom_button.dart';
import 'package:sims_ppob/presentation/widgets/forms/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Gap(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Logo.png', height: 30, width: 30),
              const Gap(8),
              const Text(
                'SIMS PPOB',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
              ),
            ],
          ),
          const Gap(32),
          const Text(
            'Lengkapi data untuk membuat akun',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              height: 1.2,
            ),
          ),
          const Gap(52),

          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: "Email",
                  hintText: "Masukkan email Anda",
                  prefixIcon: Icons.alternate_email,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    if (!value.contains("@")) {
                      return "Format email tidak valid";
                    }
                    return null;
                  },
                ),
                const Gap(12),
                CustomTextField(
                  label: "Nama Depan",
                  hintText: "Masukkan nama depan Anda",
                  prefixIcon: Icons.person_outline,
                  controller: _firstNameController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Nama depan tidak boleh kosong"
                              : null,
                ),
                const Gap(12),
                CustomTextField(
                  label: "Nama Belakang",
                  hintText: "Masukkan nama belakang Anda",
                  prefixIcon: Icons.person_outline,
                  controller: _lastNameController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Nama belakang tidak boleh kosong"
                              : null,
                ),
                const Gap(12),
                CustomTextFieldPass(
                  label: "Password",
                  hint: "Masukkan password Anda",
                  controller: _passwordController,
                ),
                const Gap(12),
                CustomTextFieldPass(
                  label: "Ulangi Password",
                  hint: "Masukkan ulang password Anda",
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ulangi password tidak boleh kosong";
                    }
                    if (value != _passwordController.text) {
                      return "Password tidak sama";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          const Gap(40),

          /// ✅ Button Register
          authProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                text: 'Register',
                color: Colors.red,
                colorText: Colors.black,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authProvider.register(
                      email: _emailController.text.trim(),
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      password: _passwordController.text.trim(),
                    );

                    if (authProvider.registerResponse?.success == true) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              authProvider.registerResponse!.message,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      }
                    } else if (authProvider.errorMessage != null) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(authProvider.errorMessage!),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                },
              ),

          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sudah punya akun?'),
              GestureDetector(
                onTap:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    ),
                child: const Text(
                  ' Login di sini',
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
    );
  }
}
