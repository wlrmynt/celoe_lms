import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/profile_screen.dart';
import 'package:celoe_lms/screens/notification_screen.dart';
import 'package:celoe_lms/screens/announcement_list_screen.dart';
import 'package:celoe_lms/screens/my_classes_screen.dart';
import 'package:celoe_lms/screens/assignment_detail_screen.dart';
import 'package:celoe_lms/screens/course_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      body: Column(
        children: [
          // 2. Header (Top Navigation)
          _buildHeader(),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3. Section “Tugas Yang Akan Datang”
                  _buildSectionTitle(
                    'Tugas Yang Akan Datang',
                    showViewAll: false,
                  ),
                  _buildUpcomingTaskCard(),
                  const SizedBox(height: 24),

                  // 4. Section “Pengumuman Terakhir”
                  _buildSectionTitle('Pengumuman Terakhir', showViewAll: true),
                  _buildAnnouncementBanner(),
                  const SizedBox(height: 24),

                  // 5. Section “Progres Kelas”
                  _buildSectionTitle('Progres Kelas', showViewAll: false),
                  _buildClassProgressList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      // 6. Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        50,
        20,
        24,
      ), // Adjust top padding for status bar
      decoration: const BoxDecoration(
        color: Color(0xFFB71C1C), // Maroon background
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hallo,',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'WILIRAMAYANTI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'MAHASISWA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
            GestureDetector(
             onTap: () {
                Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
             },
             child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: const AssetImage(
                    'assets/wil.jpg',
                  ), // Using available asset as placeholder avatar
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (showViewAll)
            TextButton(
              onPressed: () {
                if (title == 'Pengumuman Terakhir') {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AnnouncementListScreen()),
                  );
                } else if (title == 'Tugas Yang Akan Datang') {
                  // Navigate to MyClasses as a proxy for Task List or a dedicated screen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MyClassesScreen()),
                  );
                }
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(color: Color(0xFFB71C1C)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTaskCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AssignmentDetailScreen(
              assignmentTitle: 'Desain Pengalaman Pengguna',
            ),
          ),
        );
      },
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFB71C1C), // Maroon/Red background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB71C1C).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Deadline Terdekat',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Desain Pengalaman Pengguna',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tugas Heuristik Evaluation',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.calendar_today, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'Senin, 18 Des 2024 • 23:59',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildAnnouncementBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
            'assets/Learning Management System.png',
          ), // Placeholder for illustrative banner
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: const Text(
          'Jadwal Maintenance Sistem LMS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildClassProgressList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildClassProgressCard(
          'Interaksi Manusia Komputer',
          'IMK-44-02 • Semester 3',
          0.85,
          Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildClassProgressCard(
          'Pemrograman Mobile',
          'MOB-44-01 • Semester 5',
          0.45,
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _buildClassProgressCard(
          'Kewirausahaan Teknologi',
          'KWU-44-03 • Semester 7',
          0.70,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildClassProgressCard(
    String title,
    String subtitle,
    double progress,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(courseName: title),
          ),
        );
      },
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.book, color: color),
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
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          color: const Color(
                            0xFFB71C1C,
                          ), // Consistent red progress
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB71C1C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xFFB71C1C),
          indicatorColor: Colors.white.withValues(alpha: 0.2), // Light highlight for selection
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              color: Colors.white, 
              fontSize: 12, 
              fontWeight: FontWeight.w500
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Colors.white);
            }
            return const IconThemeData(color: Colors.white70);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            if (index == 1) {
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyClassesScreen()),
              );
            } else if (index == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          backgroundColor: const Color(0xFFB71C1C),
          indicatorColor: Colors.white.withValues(alpha: 0.2),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              selectedIcon: Icon(Icons.school),
              label: 'Kelas Saya',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              selectedIcon: Icon(Icons.notifications),
              label: 'Notifikasi',
            ),
          ],
        ),
      ),
    );
  }
}
