import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/announcement_detail_screen.dart';

class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, String>> announcements = [
      {
        'title': 'Maintenance Pra UAS Semester Genap 2020/2021',
        'metadata': 'By Admin Celoe - Rabu, 2 Juni 2021, 10:45',
      },
      {
        'title': 'Panduan Pelaksanaan Ujian Online',
        'metadata': 'By Akademik - Senin, 31 Mei 2021, 08:00',
      },
      {
        'title': 'Update Kebijakan Privasi Pengguna',
        'metadata': 'By Admin IT - Jumat, 28 Mei 2021, 14:30',
      },
      {
        'title': 'Jadwal Libur Perkuliahan Idul Fitri',
        'metadata': 'By Kemahasiswaan - Senin, 10 Mei 2021, 09:15',
      },
      {
        'title': 'Penerimaan Asisten Praktikum TA 2021',
        'metadata': 'By Lab Informatika - Selasa, 4 Mei 2021, 16:20',
      },
    ];

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
          'Pengumuman',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: announcements.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = announcements[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: const Text('📢', style: TextStyle(fontSize: 20)), // Megaphone emoji as consistent icon
            ),
            title: Text(
              item['title']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                item['metadata']!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AnnouncementDetailScreen(announcement: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
