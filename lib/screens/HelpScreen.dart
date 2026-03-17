import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedLanguage = 'English'; // State untuk pilihan bahasa

  // Data untuk kartu bantuan
  final List<HelpItem> _helpItems = [
    HelpItem(
      icon: Icons.key,
      iconColor: const Color(0xFFFFD700), // Gold
      iconCircleColor: const Color(0xFFEDE7F6), // Very light purple
      // cardBackgroundColor: const Color(0xFF5E35B1), // Deep purple
      cardBackgroundColor: Colors.teal[400]!, // Teal
      title: 'Bagaimana Cara Reset Password?',
    ),
    HelpItem(
      icon: Icons.calendar_today,
      iconColor: const Color(0xFFEF5350), // Red
      iconCircleColor: const Color(0xFFFFEBEE), // Very light red
      cardBackgroundColor: Colors.white,
      title: 'Bagaimana Cara Mengubah Tanggal Reksa Uji?',
    ),
    HelpItem(
      icon: Icons.build, // Wrench icon
      iconColor: const Color(0xFFFFA726), // Orange
      iconCircleColor: const Color(0xFFE8F5E9), // Very light green
      cardBackgroundColor: Colors.white,
      title: 'Bagaimana Cara Mengetahui Status Reksa Uji?',
    ),
    HelpItem(
      icon: Icons.notifications,
      iconColor: const Color(0xFF42A5F5), // Blue
      iconCircleColor: const Color(0xFFE3F2FD), // Very light blue
      cardBackgroundColor: Colors.white,
      title: 'Bagaimana Cara Menyesuaikan Pemberitahuan?',
    ),
    HelpItem(
      icon: Icons.verified_user, // Shield icon
      iconColor: const Color(0xFF66BB6A), // Green
      iconCircleColor: const Color(0xFFE8F5E9), // Very light green
      cardBackgroundColor: Colors.white,
      title: 'Bagaimana Cara Menyimpan Data dan Mematuhi Keamanannya?',
    ),
    HelpItem(
      icon: Icons.star,
      iconColor: const Color(0xFFFFCA28), // Amber
      iconCircleColor: const Color(0xFFFFF3E0), // Very light orange
      cardBackgroundColor: Colors.white,
      title: 'Bagaimana Cara Memperbarui Versi Pro?',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar-like section
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Help and Support',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedLanguage,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue!;
                        });
                      },
                      items: <String>['English', 'Bahasa Indonesia']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              const Icon(Icons.language, size: 18, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'What would you like to find?',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: Icon(Icons.mic, color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Help Cards Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0, // Adjust as needed
              ),
              itemCount: _helpItems.length,
              itemBuilder: (context, index) {
                return _buildHelpCard(_helpItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard(HelpItem item) {
    return Container(
      decoration: BoxDecoration(
        color: item.cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.iconCircleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: TextStyle(
                color: item.cardBackgroundColor == Colors.white ? Colors.black87 : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class untuk data kartu bantuan
class HelpItem {
  final IconData icon;
  final Color iconColor;
  final Color iconCircleColor;
  final Color cardBackgroundColor;
  final String title;

  HelpItem({
    required this.icon,
    required this.iconColor,
    required this.iconCircleColor,
    required this.cardBackgroundColor,
    required this.title,
  });
}