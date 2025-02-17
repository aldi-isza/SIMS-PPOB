class PaymentModel {
  final String label;
  final String imageUrl;

  PaymentModel({required this.label, required this.imageUrl});
}

final List<PaymentModel> paymentList = [
  PaymentModel(label: 'PBB', imageUrl: 'assets/PBB.png'),
  PaymentModel(label: 'Listrik', imageUrl: 'assets/Listrik.png'),
  PaymentModel(label: 'Pulsa', imageUrl: 'assets/Pulsa.png'),
  PaymentModel(label: 'PDAM', imageUrl: 'assets/PDAM.png'),
  PaymentModel(label: 'PGN', imageUrl: 'assets/PGN.png'),
  PaymentModel(label: 'Televisi', imageUrl: 'assets/Televisi.png'),
  PaymentModel(label: 'Musik', imageUrl: 'assets/Musik.png'),
  PaymentModel(label: 'Game', imageUrl: 'assets/Game.png'),
  PaymentModel(label: 'Makanan', imageUrl: 'assets/Makanan.png'),
  PaymentModel(label: 'Kurban', imageUrl: 'assets/Kurban.png'),
  PaymentModel(label: 'Zakat', imageUrl: 'assets/Zakat.png'),
  PaymentModel(label: 'Data', imageUrl: 'assets/Data.png'),
];
