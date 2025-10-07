import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:sims_ppob/features/home/data/models/banner_model.dart';
import 'package:sims_ppob/features/payment/data/models/payment_model.dart';
import 'package:sims_ppob/common/widgets/card/saldo_card_widget.dart';
import 'package:sims_ppob/features/payment/payment_page.dart';
import '../../../common/widgets/widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/Logo.png', height: 22, width: 22),
                Gap(8),
                Text(
                  'SIMS PPOB',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Image.asset('assets/Profile Photo.png'),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang,',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  color: Colors.grey[600],
                ),
              ),
              Gap(4),
              Text(
                'Aldi Isza',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Gap(32),

              SaldoCard(saldo: 2000000, showVisibilityToggle: true),
              Gap(24),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 9,
                  childAspectRatio: 0.7,
                ),
                itemCount: paymentList.length,
                itemBuilder: (context, index) {
                  return PaymentItem(
                    paymentModel: paymentList[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PaymentPage(
                                label: paymentList[index].label,
                                imageUrl: paymentList[index].imageUrl,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
              Gap(24),
              Text(
                'Temukan promo menarik',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Gap(12),
              BannerWidget(bannerList: bannerList),
            ],
          ),
        ),
      ),
    );
  }
}
