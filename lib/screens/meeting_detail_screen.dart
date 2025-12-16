import 'package:flutter/material.dart';

class MeetingDetailScreen extends StatefulWidget {
  final String meetingTitle;

  const MeetingDetailScreen({super.key, required this.meetingTitle});

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFB71C1C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          widget.meetingTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryRed,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primaryRed,
          tabs: const [
            Tab(text: 'Deskripsi'),
            Tab(text: 'Materi Dan Kuis'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Deskripsi
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pengantar User Interface Design',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'User Interface (UI) Design adalah proses yang digunakan desainer untuk membuat tampilan dalam perangkat lunak atau perangkat terkomputerisasi, dengan fokus pada tampilan atau gaya. Desainer UI bertujuan untuk membuat desain antarmuka yang mudah digunakan dan menyenangkan.',
                  style: TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                // Illustration as per description
                Center(
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('assets/1.png'), // Using available asset as placeholder
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tujuan utama dari UI design adalah untuk membuat interaksi pengguna seefisien dan sesederhana mungkin (user-friendly). Hal ini mencakup elemen-elemen seperti tombol, ikon, tipografi, warna, dan tata letak yang konsisten.',
                  style: TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),

          // Tab 2: Materi Dan Kuis
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildMaterialItem('Zoom Meeting Synchronous', 'Video Conference', true),
              const SizedBox(height: 12),
              _buildMaterialItem('Slide Presentasi - Pengantar UI', 'PDF Document', true),
              const SizedBox(height: 12),
              _buildMaterialItem('Artikel: Sejarah Perkembangan UI', 'Web Link', true),
              const SizedBox(height: 12),
              _buildMaterialItem('Video: UI vs UX', 'Video', false),
              const SizedBox(height: 12),
              _buildMaterialItem('Kuis: Pemahaman Dasar', 'Quiz', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialItem(String title, String type, bool isCompleted) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon based on type
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFB71C1C).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForType(type),
              color: const Color(0xFFB71C1C),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          if (isCompleted)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    if (type.contains('Video')) return Icons.play_circle_fill_outlined;
    if (type.contains('PDF')) return Icons.picture_as_pdf_outlined;
    if (type.contains('Quiz')) return Icons.quiz_outlined;
    if (type.contains('Link')) return Icons.link;
    return Icons.description_outlined;
  }
}
