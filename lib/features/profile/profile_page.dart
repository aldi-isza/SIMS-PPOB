import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sims_ppob/features/auth/presentation/login_page.dart';
import 'package:sims_ppob/common/widgets/forms/custom_form_field.dart';
import '../../common/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Akun', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  ProfilePicture(),
                  Gap(8),
                  Text(
                    'Aldi Isza',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ],
              ),
            ),
            Gap(34),
            Text('Email', style: TextStyle(fontSize: 16)),
            Gap(8),
            CustomTextField(
              hintText: 'Isza@nutech.com',
              prefixIcon: Icons.alternate_email,
            ),
            Gap(22),
            Text('Nama Depan', style: TextStyle(fontSize: 16)),
            Gap(8),
            CustomTextField(hintText: 'Aldi', prefixIcon: Icons.person_outline),
            Gap(22),
            Text('Nama Belakang', style: TextStyle(fontSize: 16)),
            Gap(8),
            CustomTextField(hintText: 'Isza', prefixIcon: Icons.person_outline),
            Gap(24),

            CustomButton(
              text: _isEditing ? 'Simpan' : 'Edit Profil',
              color: Colors.red,
              onPressed: _toggleEditMode,
              colorText: Colors.white,
            ),
            Gap(24),
            CustomButton(
              colorBorder: Colors.red,
              text: _isEditing ? 'Batalkan' : 'Logout',
              color: Colors.white,
              // jika
              onPressed: _isEditing ? _toggleEditMode : _logout,
              colorText: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
