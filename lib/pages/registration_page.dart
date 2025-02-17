import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sims_ppob/pages/dashboard_page.dart';
import 'package:sims_ppob/widgets/custom_button.dart';
import 'package:sims_ppob/widgets/custom_textfield.dart';
import 'package:sims_ppob/widgets/custom_textfield_pass.dart';

final _formKey = GlobalKey<FormState>();

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,

        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Logo.png', height: 30, width: 30),
                        Gap(8),
                        Text(
                          'SIMS PPOB',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    Gap(32),
                    Text(
                      textAlign: TextAlign.center,

                      'Lengkapi data untuk membuat akun',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                        height: 1.2,
                      ),
                    ),
                    Gap(52),
                    CustomTextField(
                      hintText: 'Masukkan email Anda',
                      prefixIcon: Icons.alternate_email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Gap(12),
                    CustomTextField(
                      hintText: 'Nama depan',
                      prefixIcon: Icons.person_outline,
                    ),
                    Gap(12),
                    CustomTextField(
                      hintText: 'Nama belakang',
                      prefixIcon: Icons.person_outline,
                    ),
                    Gap(12),
                    CustomTextFieldPass(
                      controller: _passwordController,
                      text: 'Masukan password anda',
                    ),
                    Gap(12),
                    CustomTextFieldPass(
                      controller: _confirmPasswordController,
                      text: 'Konfirmasi password anda',

                      validator:
                          (value) =>
                              value != _passwordController.text
                                  ? 'Password tidak sama'
                                  : null,
                    ),

                    Gap(52),
                    CustomButton(
                      text: 'Registrasi',
                      color: Colors.red,
                      onPressed:
                          () =>
                              _formKey.currentState!.validate()
                                  ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardPage(),
                                    ),
                                  )
                                  : null,

                      colorText: Colors.white,
                    ),

                    Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah punya akun? login'),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
