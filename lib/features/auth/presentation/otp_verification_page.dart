import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatefulWidget {
  final String destination; // email atau nomor WA tujuan OTP

  const OtpVerificationPage({super.key, required this.destination});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() => _canResend = true);
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _submitOtp() {
    final otp = _otpController.text;
    if (otp.length == 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("OTP entered: $otp")));
      // TODO: panggil API verifikasi OTP
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kode OTP harus 6 digit")));
    }
  }

  void _resendCode() {
    if (_canResend) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kode baru dikirim")));
      // TODO: panggil API resend OTP
      _startTimer();
    }
  }

  /// Tombol numpad clean
  Widget buildNumpadButton(
    String label, {
    VoidCallback? onTap,
    bool isIcon = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        alignment: Alignment.center,
        child:
            isIcon
                ? const Icon(
                  Icons.backspace_outlined,
                  size: 28,
                  color: Colors.black,
                )
                : Text(
                  label,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
      ),
    );
  }

  /// Numpad grid
  Widget buildNumpad() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index == 9) return const SizedBox(); // kosong

        if (index == 11) {
          return buildNumpadButton(
            "del",
            onTap: () {
              if (_otpController.text.isNotEmpty) {
                setState(() {
                  _otpController.text = _otpController.text.substring(
                    0,
                    _otpController.text.length - 1,
                  );
                });
              }
            },
            isIcon: true,
          );
        }

        final number = (index == 10) ? 0 : index + 1;
        return buildNumpadButton(
          number.toString(),
          onTap: () {
            if (_otpController.text.length < 6) {
              setState(() {
                _otpController.text += number.toString();
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              "OTP Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "An Authentication code has been sent to",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              widget.destination,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),

            /// OTP Box
            Pinput(
              length: 6,
              controller: _otpController,
              readOnly: true, // ✅ input hanya dari numpad custom
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              showCursor: true,
            ),

            const SizedBox(height: 24),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Countdown / Resend
            _canResend
                ? GestureDetector(
                  onTap: _resendCode,
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : Text(
                  "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

            const Spacer(),

            /// Custom Numpad
            buildNumpad(),
          ],
        ),
      ),
    );
  }
}
