import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:celoe_lms/screens/quiz_screen.dart';

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
          // Tab 1: Deskripsi (Rich Header & Instructor)
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 // Feature Image
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/UX.png'), // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
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
                const SizedBox(height: 24),

                // Instructor Info Section
                const Text(
                  'Dosen Pengampu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: Colors.grey[200]!),
                   ),
                   child: Row(
                     children: [
                       const CircleAvatar(
                         radius: 30,
                         backgroundColor: Colors.grey,
                         child: Icon(Icons.person, color: Colors.white, size: 30),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text(
                               'Aditya Rachman, S.T., M.Kom.',
                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                             ),
                             const SizedBox(height: 4),
                             Text(
                               'Expertise: HCI, UX Research',
                               style: TextStyle(color: Colors.grey[600], fontSize: 12),
                             ),
                              const SizedBox(height: 8),
                              Row(
                                children: const [
                                  Icon(Icons.email_outlined, size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text('aditya@telkomuniversity.ac.id', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              )
                           ],
                         ),
                       ),
                     ],
                   ),
                ),

                const SizedBox(height: 24),
                // Mid-Scroll Callout Illustration
                Center(
                  child: Image.asset('assets/1.png', height: 120),
                ),
              ],
            ),
          ),

          // Tab 2: Materi Dan Kuis (Video & Content)
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Main Video Area
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Memutar Video Pembelajaran...')),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
                       SizedBox(height: 8),
                       Text('Putar Video Pembelajaran', style: TextStyle(color: Colors.white)),
                     ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
               const Text(
                'Video: Konsep Dasar UI Design',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              
              const Text('Materi Pembelajaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),

              _buildMaterialItem('Slide Presentasi - Pengantar UI', 'PDF Document', true),
              const SizedBox(height: 12),
              _buildMaterialItem('Artikel: Sejarah Perkembangan UI', 'Web Link', true),
              const SizedBox(height: 12),
              _buildMaterialItem('Kuis: Pemahaman Dasar', 'Quiz', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialItem(String title, String type, bool isCompleted) {
    return GestureDetector(
      onTap: () async {
        if (type == 'Quiz') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizScreen()),
          );
          return;
        }

        String urlString = 'https://www.google.com';
        String message = 'Membuka Link...';

        if (type.contains('PDF')) {
          urlString = 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
          message = 'Membuka PPT...';
        } else if (type.contains('Web Link') || type.contains('Link')) {
          urlString = 'https://en.wikipedia.org/wiki/User_interface_design'; // Relevant Article
          message = 'Membuka Artikel...';
        }

        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
        
        final Uri url = Uri.parse(urlString);
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          if (context.mounted) {
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not launch $urlString')),
            );
          }
        }
      },
      child: Container(
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
