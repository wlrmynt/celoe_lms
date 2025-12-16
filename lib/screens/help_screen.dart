import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  // Simulating language selection state
  bool isId = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bantuan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Pengaturan Bahasa (Language Switcher)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLanguageOption(
                    'ID', true, Icons.flag), // Using flag icon as placeholder
                const SizedBox(width: 32),
                _buildLanguageOption(
                    'EN', false, Icons.outlined_flag), // Different icon for visual distinction
              ],
            ),
            const SizedBox(height: 32),

            // 3. Judul dan Pernyataan Akses
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Text(
                'Akses hanya untuk Dosen dan Mahasiswa Telkom University.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),

            // 4. Instruksi Login Office 365
            _buildSectionTitle('Petunjuk Login Office 365'),
            const SizedBox(height: 12),
            _buildInstructionText(
                '1. Pastikan Anda menggunakan akun: Microsoft Office 365 Anda.'),
            _buildInstructionText(
                '2. Username: Masukkan email lengkap (contoh: nama@telkomuniversity.ac.id).'),
            _buildInstructionText(
                '3. Password: Gunakan password akun SSO Anda yang aktif.'),
            const SizedBox(height: 24),

            // 5. Penjelasan Penyebab Gagal Autentikasi
            _buildSectionTitle('Masalah Autentikasi?'),
            const SizedBox(height: 12),
            const Text(
              'Gagal login sering disebabkan oleh password yang kadaluarsa atau belum memenuhi standar keamanan. Pastikan akun Anda sudah mengaktifkan "Strong Password". Silakan reset password di i-Gracias jika diperlukan.',
              style: TextStyle(height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 32),

            // 6. Informasi Kontak Helpdesk
            _buildSectionTitle('Butuh Bantuan?'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFB71C1C).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildContactItem(Icons.email, 'helpdesk@telkomuniversity.ac.id'),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildContactItem(Icons.chat, 'WhatsApp: +62 812-3456-7890'),
                ],
              ),
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, bool isSelected, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isId = code == 'ID';
        });
      },
      child: Column(
        children: [
          Icon(
            icon, 
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
            size: 32
          ),
          const SizedBox(height: 8),
          Text(
            code,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey,
              decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
              decorationColor: const Color(0xFFB71C1C),
              decorationThickness: 2,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFB71C1C),
      ),
    );
  }
  
  Widget _buildInstructionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 18, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFB71C1C), size: 22),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
