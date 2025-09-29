import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sims_ppob/features/auth/presentation/register_page.dart';
import 'package:sims_ppob/presentation/pages/dashboard/dashboard_page.dart';

import '../../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                  ),
                ],
              ),
              Gap(32),
              Text(
                textAlign: TextAlign.center,

                'Masuk atau buat akun untuk memulai',
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
              CustomTextFieldPass(text: 'Masukan password anda'),
              Gap(52),
              CustomButton(
                text: 'Masuk',
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                colorText: Colors.white,
              ),

              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun? registrasi'),
                  GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        ),
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
    );
  }
}
