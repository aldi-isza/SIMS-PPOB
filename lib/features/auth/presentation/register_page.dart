import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/features/auth/provider/auth_provider.dart';
import 'package:sims_ppob/presentation/pages/login/login_page.dart';
import 'package:sims_ppob/presentation/widgets/buttons/custom_button.dart';
import 'package:sims_ppob/presentation/widgets/forms/custom_textfield.dart';
import 'package:sims_ppob/presentation/widgets/forms/custom_textfield_pass.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                // Logo
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

                // Input fields
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
                const Gap(52),

                // Button
                authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                      text: 'Register',
                      color: Colors.red,
                      colorText: Colors.black,
                      onPressed: () async {
                        print("=== DEBUG FORM INPUT ===");
                        print("Email: ${_emailController.text}");
                        print("First Name: ${_firstNameController.text}");
                        print("Last Name: ${_lastNameController.text}");
                        print("Password: ${_passwordController.text}");

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
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
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
                      },
                    ),

                const Gap(24),
                // Link ke Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun?'),
                    GestureDetector(
                      onTap:
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
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
          ),
        ],
      ),
    );
  }
}
