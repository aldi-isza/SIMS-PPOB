import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sims_ppob/features/auth/presentation/otp_verification_page.dart';
import 'package:sims_ppob/features/auth/presentation/register_page.dart';

import 'package:sims_ppob/presentation/widgets/buttons/buttons.dart';
import 'package:sims_ppob/presentation/widgets/buttons/colors.dart';
import 'package:sims_ppob/presentation/widgets/buttons/text_label.dart';
import 'package:sims_ppob/presentation/widgets/forms/custom_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
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
              TextLabel(label: 'Email'),
              Gap(8),
              CustomTextField(
                hintText: 'Masukkan email Anda',
                prefixIcon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  return null;
                },
              ),

              Gap(12),
              TextLabel(label: 'Password'),
              Gap(8),
              CustomTextFieldPass(hint: 'Masukan Password anda'),

              Gap(24),
              Row(children: [ 
                
              ],),
              Button.filled(
                label: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OtpVerificationPage(destination: ''),
                    ),
                  );
                },
              ),
              Gap(12),
              Text('OR', style: TextStyle(color: AppColors.grey)),
              Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        ),
                    child: Text(
                      ' Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
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
