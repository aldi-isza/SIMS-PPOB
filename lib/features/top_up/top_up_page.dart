import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sims_ppob/features/dashboard/presentation/dashboard_page.dart';
import 'package:sims_ppob/common/widgets/forms/custom_form_field.dart';
import '../../common/widgets/card/saldo_card_widget.dart';
import '../../common/widgets/widgets.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChangeAmount);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChangeAmount);
    _controller.dispose();
    super.dispose();
  }

  void _onAmountSelected(int amount) {
    setState(() {
      _controller.text = amount.toString();
      _isButtonActive = true;
    });
  }

  void _onChangeAmount() {
    setState(() {
      int? amount = int.tryParse(_controller.text);
      _isButtonActive = (amount != null && amount >= 10000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Top Up', style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SaldoCard(saldo: 2000000, showVisibilityToggle: false),
              Gap(48),
              Text(
                'Silahkan masukan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'nominal Top Up',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Gap(45),
              CustomTextField(
                controller: _controller,
                hintText: 'masukan nilai Top Up',
                prefixIcon: Icons.money,
                keyboardType: TextInputType.number,
                validator: (value) {
                  // jika nilai tidak kosong
                  if (value != null && value.isNotEmpty) {
                    // coba ubah nilai value menjadi integer
                    int? amount = int.tryParse(value);
                    // jika jumlahnya tidak null atau kurang dari 10000
                    if (amount != null && amount < 10000) {
                      // maka tampilkan pesan berikut
                      return 'Minimal top up Rp 10.000';
                    }
                  }
                  // tidak ada eror jika kosong
                  return null;
                },
              ),
              Gap(24),
              GridAmount(onSelected: _onAmountSelected),

              // CustomButton(
              //   text: 'Top Up',
              //   color: _isButtonActive ? Colors.red : Colors.grey,
              //   onPressed: () {
              //     if (_isButtonActive == true) {
              //       _showConfirmationDialog(context);
              //     }
              //   },
              //   colorText: Colors.white,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// menerima dengan parameter string label
void _showConfirmationDialog(context) {
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
                  image: DecorationImage(image: AssetImage('assets/Logo.png')),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Anda yakin untuk Top Up sebesar ',
                textAlign: TextAlign.center,
              ),
              Text(
                50000.currencyFormatRp,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                child: Text(
                  'Ya, lanjutkan Top Up',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Batalkan',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
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
