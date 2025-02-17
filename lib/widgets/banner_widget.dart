import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob/models/banner_model.dart';

class BannerWidget extends StatelessWidget {
  final List<BannerModel> bannerList;

  const BannerWidget({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200, // Tinggi banner
        autoPlay: true, // Auto slide
        autoPlayInterval: const Duration(seconds: 5), // Interval per slide
        enlargeCenterPage: true, // Efek zoom di tengah
        viewportFraction: 1, // Lebar tiap item
      ),
      items:
          bannerList.map((banner) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12), // Sudut membulat
              child: Image.asset(
                banner.imageUrl,
                fit: BoxFit.cover, // Pastikan gambar penuh
                width: double.infinity,
              ),
            );
          }).toList(),
    );
  }
}
