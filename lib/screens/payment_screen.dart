import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _currentPage = 0;
  int _selectedPaymentOption = 0; 

  final List<PaymentCard> _paymentCards = [
    PaymentCard(
      cardType: 'BCA CARD',
      cardNumber: '8763 2736 9873 0329',
      cardHolderName: 'Gibson Trifai Tambunan',
      expiryDate: '10/28',
      gradientColors: [
        Colors.green.shade400,
        Colors.green.shade700,
      ],
      logo: 'assets/Logo_BCA.png',
    ),
    PaymentCard(
      cardType: 'BNI CARD',
      cardNumber: '5432 1098 7654 3210',
      cardHolderName: 'Gibson Trifai Tambunan',
      expiryDate: '12/26',
      gradientColors: [
        Colors.orange.shade400,
        Colors.orange.shade700,
      ],
      logo: 'assets/bni.png', 
    ),
  ];
  final List<PaymentOption> _paymentOptions = [
    PaymentOption(
      name: 'Master Card',
      lastFourDigits: '2586',
      logo: 'assets/mastercard_logo.png',
    ),
    PaymentOption(
      name: 'BCA',
      lastFourDigits: '2875',
      logo: 'assets/Logo_BCA.png', 
    ),
    PaymentOption(
      name: 'Mandiri',
      lastFourDigits: '2875',
      logo: 'assets/mandiri.png', 
    ),
    PaymentOption(
      name: 'BNI',
     lastFourDigits: '1290',
      logo: 'assets/bni.png', 
    ),
    PaymentOption(
      name: 'DKI',
      lastFourDigits: '1200',
      logo: 'assets/dki.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Infinity Pay',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              
              SizedBox(
                height: 200, 
                child: PageView.builder(
                  itemCount: _paymentCards.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildCreditCard(_paymentCards[index]);
                  },
                ),
              ),
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _paymentCards.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Add New Card',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
        
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _paymentOptions.length,
                itemBuilder: (context, index) {
                  return _buildPaymentOption(
                    _paymentOptions[index],
                    index,
                  );
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Melakukan pembayaran dengan ${_paymentOptions[_selectedPaymentOption].name}'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600, // Warna hijau
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard(PaymentCard card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: card.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: card.gradientColors.last.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.cardType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.wifi, color: Colors.white, size: 24), // Icon NFC/Wifi
            ],
          ),
          Text(
            card.cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Holder Name',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    card.cardHolderName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expired Date',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    card.expiryDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Placeholder for card logo (e.g., Visa Electron)
              // Anda bisa menggunakan Image.asset atau Image.network di sini
              // Untuk saat ini, saya akan menggunakan Text sebagai placeholder
              Image.asset(card.logo, height: 30), // Pastikan aset ini ada
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(PaymentOption option, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Placeholder for payment option logo
          Image.asset(option.logo, height: 24), // Pastikan aset ini ada
          const SizedBox(width: 15),
          Text(
            option.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '****${option.lastFourDigits}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Radio<int>(
            value: index,
            groupValue: _selectedPaymentOption,
            onChanged: (int? value) {
              setState(() {
                _selectedPaymentOption = value!;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Helper class untuk data kartu pembayaran
class PaymentCard {
  final String cardType;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final List<Color> gradientColors;
  final String logo;

  PaymentCard({
    required this.cardType,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.gradientColors,
    required this.logo,
  });
}
class PaymentOption {
  final String name;
  final String lastFourDigits;
  final String logo;

  PaymentOption({
    required this.name,
    required this.lastFourDigits,
    required this.logo,
  });
}