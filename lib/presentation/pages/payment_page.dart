import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sims_ppob/presentation/pages/dashboard_page.dart';
import '../widgets/widgets.dart';

class PaymentPage extends StatelessWidget {
  final String label;
  final String imageUrl;
  const PaymentPage({super.key, required this.label, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pembayaran',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SaldoCard(saldo: 2000000, showVisibilityToggle: false),
              Gap(50),
              Text(
                'Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Gap(8),

              Row(
                children: [
                  Image.asset(imageUrl, width: 40, height: 40),
                  Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Gap(24),
              CustomTextField(hintText: '10000', prefixIcon: Icons.money),
              Gap(250),
              CustomButton(
                text: 'Bayar',
                color: Colors.red,
                onPressed: () {
                  // mengirim label
                  _showConfirmationDialog(context, label);
                },
                colorText: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// menerima dengan parameter string label
void _showConfirmationDialog(context, String label) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.close, size: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Text('Pembayaran $label sebesar', textAlign: TextAlign.center),
              Text(
                50000.currencyFormatRp,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),

              Text('gagal', style: TextStyle(fontSize: 18)),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                child: Text(
                  'Kembali ke Beranda',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
