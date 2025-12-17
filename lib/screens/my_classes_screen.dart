import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/notification_screen.dart';
import 'package:celoe_lms/screens/course_detail_screen.dart';

class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  int _selectedIndex = 1; // Default to 'Kelas Saya'

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFB71C1C);

    final List<Map<String, dynamic>> classes = [
      {
        'semester': '2021/2',
        'name': 'KEWARGANEGARAAN',
        'code': 'D4SM-42-03 [ADY]',
        'progress': 0.89,
        'image': 'assets/gambar1.png', // Using available asset
      },
      {
        'semester': '2021/2',
        'name': 'DESAIN UI/UX',
        'code': 'D4SM-44-01 [GHE]',
        'progress': 0.75,
        'image': 'assets/gambar2.png', // Using available asset
      },
      {
        'semester': '2021/2',
        'name': 'PEMROGRAMAN WEB',
        'code': 'D4SM-42-02 [RZA]',
        'progress': 0.45,
        'image': 'assets/gambar3.png', // Using available asset
      },
      {
        'semester': '2021/2',
        'name': 'BAHASA INGGRIS',
        'code': 'D4SM-41-GAB1 [STL]',
        'progress': 1.0,
        'image': 'assets/Splash Screen.png', // Using available asset
      },
    ];

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
        title: const Text(
          'Kelas Saya',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final item = classes[index];
          return _buildClassCard(item, primaryRed);
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: primaryRed,
          indicatorColor: Colors.white.withValues(alpha: 0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return const IconThemeData(color: Colors.white);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            if (index == 0) {
              Navigator.of(context).pop(); // Go back to Home
            } else if (index == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          backgroundColor: primaryRed,
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

  Widget _buildClassCard(Map<String, dynamic> item, Color primaryRed) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(courseName: item['name']),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['semester'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Adjusted for card space
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['code'],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Progress Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(item['progress'] * 100).toInt()}% Selesai',
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: item['progress'],
                        backgroundColor: Colors.grey[200],
                        color: primaryRed,
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
