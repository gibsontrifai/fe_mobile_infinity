import 'package:flutter/material.dart';
import 'package:safetyfeapps/screens/login_k3_page.dart';
import 'package:safetyfeapps/screens/payment_screen.dart';
import 'package:safetyfeapps/screens/ScheduleScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Row(
              children: [
                _buildProfileCard(
                  icon: Icons.account_balance_wallet,
                  title: 'Balance',
                  value: 'Rp 50.000',
                  valueColor: Colors.teal[400], 
                ),
                const SizedBox(width: 16),
                _buildProfileCard(
                  icon: Icons.group,
                  title: 'Friends invited',
                  value: '10',
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal[400], 
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person_add, color: Colors.white, size: 30),
                        SizedBox(height: 8),
                        Text(
                          'Register Partner',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'Informasi K3',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(Icons.document_scanner_outlined, 'Suket K3', trailingText: 'Active', trailingColor: Colors.teal[400]),
            _buildSettingItem(Icons.safety_check_outlined , 'Reksa Uji K3', trailingText: 'Active', trailingColor: Colors.teal[400]),
            const SizedBox(height: 32),
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(Icons.person_outline, 'Personal information'),
            _buildSettingItem(Icons.payments_outlined, 'Payments', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentScreen()),
              );
            }),
            _buildSettingItem(Icons.privacy_tip_outlined, 'Privacy'),
            _buildSettingItem(Icons.notifications_none, 'Notifications'),
            _buildSettingItem(Icons.calendar_today_outlined, 'Jadwal', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              );
            }),
            _buildSettingItem(Icons.logout_outlined, 'Logout', onTap: () {
              Navigator.pushReplacement(context, 
              MaterialPageRoute(builder: (context) => const LoginK3Page()));
            } ),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.grey[600], size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, {String? trailingText, Color? trailingColor, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          if (trailingText != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: trailingColor ?? Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                trailingText,
                style: TextStyle(
                  color: trailingColor != null ? Colors.white : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    ), // Kurung tutup ini yang hilang
    );
  }
}