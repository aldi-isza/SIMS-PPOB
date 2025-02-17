import 'package:flutter/material.dart';

import 'package:sims_ppob/widgets/int_ext.dart';

class GridAmount extends StatelessWidget {
  final Function(int) onSelected;
  const GridAmount({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final List<int> amount = [10000, 20000, 50000, 100000, 250000, 500000];

    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
          childAspectRatio: 2,
        ),
        itemCount: amount.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onSelected(amount[index]),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              alignment: Alignment.center,
              child: Text(
                amount[index].currencyFormatRp,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
