import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/core/providers/saldo_provider.dart';


class SaldoCard extends StatelessWidget {
  const SaldoCard({super.key, required int saldo, required bool showVisibilityToggle});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaldoProvider>(
      builder: (context, saldoProvider, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Saldo Anda",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                saldoProvider.isHidden
                    ? "••••••"
                    : NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(saldoProvider.saldo),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => saldoProvider.toggleVisibility(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      saldoProvider.isHidden
                          ? "Tampilkan Saldo"
                          : "Sembunyikan Saldo",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      saldoProvider.isHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
