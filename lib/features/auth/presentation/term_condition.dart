import 'package:flutter/material.dart';

class TermsConditionsWidget extends StatefulWidget {
  final VoidCallback onAccepted; // callback saat user setuju
  final String termsText;

  const TermsConditionsWidget({
    super.key,
    required this.onAccepted,
    required this.termsText,
  });

  @override
  State<TermsConditionsWidget> createState() => _TermsConditionsWidgetState();
}

class _TermsConditionsWidgetState extends State<TermsConditionsWidget> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Teks T&C
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.termsText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ),

        const Divider(),

        // Checkbox + Label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: _isAgreed,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() => _isAgreed = value ?? false);
                },
              ),
              const Expanded(
                child: Text(
                  "Saya telah membaca dan menyetujui Syarat & Ketentuan",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),

        // Tombol Aksi
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isAgreed ? widget.onAccepted : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Lanjutkan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
