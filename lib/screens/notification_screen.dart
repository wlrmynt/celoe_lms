import 'package:flutter/material.dart';

import 'package:celoe_lms/screens/assignment_detail_screen.dart';
import 'package:celoe_lms/screens/quiz_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for Notifications
    final List<Map<String, dynamic>> notifications = [
      {
        'type': 'task',
        'message': 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
        'time': '2 Menit Yang Lalu',
      },
      {
        'type': 'quiz',
        'message': 'Kuis "Struktur Data - Pertemuan 14" akan segera berakhir dalam 1 jam.',
        'time': '1 Jam Yang Lalu',
      },
      {
        'type': 'task',
        'message': 'Nilai tugas "Desain UI/UX - Assessment 2" telah dirilis. Silakan cek detail penilaian.',
        'time': '5 Jam Yang Lalu',
      },
      {
        'type': 'info',
        'message': 'Pengumuman: Jadwal maintenance server pada hari Sabtu, 23 Des 2024 pukul 00:00 - 04:00 WIB.',
        'time': '1 Hari Yang Lalu',
      },
      {
        'type': 'task',
        'message': 'Tugas baru "Analisis Algoritma" telah ditambahkan ke kelas D4SM-44-02.',
        'time': '2 Hari Yang Lalu',
      },
      {
        'type': 'quiz',
        'message': 'Anda berhasil menyelesaikan Kuis "Logika Matematika".',
        'time': '3 Hari Yang Lalu',
      },
       {
        'type': 'task',
        'message': 'Pengingat: Batas pengumpulan tugas "Pemrograman Web" adalah besok.',
        'time': '3 Hari Yang Lalu',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // 2. App Bar (Header Navigasi)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // 3. Struktur Daftar Notifikasi
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return _buildNotificationItem(notif);
        },
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notif) {
    IconData icon;
    Color iconColor;

    // 5. Ikon Notifikasi
    switch (notif['type']) {
      case 'task':
        icon = Icons.description_outlined;
        iconColor = Colors.black87;
        break;
      case 'quiz':
        icon = Icons.quiz_outlined;
        iconColor = Colors.black87;
        break;
      default:
        icon = Icons.info_outline;
        iconColor = Colors.grey;
    }

    return InkWell(
      onTap: () {
        if (notif['type'] == 'task') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AssignmentDetailScreen(assignmentTitle: 'Detail Tugas'),
          ));
        } else if (notif['type'] == 'quiz') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const QuizScreen(),
          ));
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Pesan: ${notif['message']}')),
           );
        }
      },
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 4. Konten Teks Notifikasi
                Text(
                  notif['message'],
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notif['time'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
