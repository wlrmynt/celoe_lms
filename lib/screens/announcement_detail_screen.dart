import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Map<String, String> announcement;

  const AnnouncementDetailScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Detail Pengumuman',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // 3. Visual Utama (Ilustrasi)
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/Learning Management System.png'), // Reusing existing asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Judul Utama
            Text(
              announcement['title']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
             const SizedBox(height: 8),
             
             // Metadata
             Text(
              announcement['metadata']!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
             
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),

            // Isi Teks/Konten
            const Text(
              'Maintenance LMS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Yth. Dosen dan Mahasiswa Telkom University,',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'Sehubungan dengan adanya pemeliharaan dan peningkatan performa server (Server Maintenance), kami informasikan bahwa layanan CELOE LMS tidak dapat diakses pada:',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
             Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0), // Light Orange/Warning background
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('📅 Tanggal: Sabtu, 12 Juni 2021', style: TextStyle(fontWeight: FontWeight.w500)),
                   SizedBox(height: 8),
                   Text('⏰ Waktu: 00.00 - 06.00 WIB', style: TextStyle(fontWeight: FontWeight.w500)),
                   SizedBox(height: 8),
                   Text('⚠️ Dampak: Akses LMS ditutup sementara', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mohon maaf atas ketidaknyamanan yang ditimbulkan. Pastikan Anda telah menyimpan ("save") aktivitas belajar Anda sebelum waktu maintenance dimulai.',
              style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            
            // Penutup Surat Resmi
            const Text(
              'Hormat Kami,',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'CELOE Telkom University',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
