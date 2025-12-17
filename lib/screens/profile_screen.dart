import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/notification_screen.dart';
import 'package:celoe_lms/screens/my_classes_screen.dart';
import 'package:celoe_lms/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _bottomNavIndex = 1; // Default to 'Kelas Saya' or just keep it purely visual if needed

  // Edit Profile Controllers
  final _firstNameController = TextEditingController(text: "Wiliramayanti");
  final _lastNameController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "wiliramayanti@student.uim.ac.id");
  final _countryController = TextEditingController(text: "Indonesia");
  final _descController = TextEditingController(text: "Mahasiswa Informatika angkatan 2021.");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFB71C1C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 2. Header Profil
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: const BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'PROFIL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48), // Spacer for balance
                  ],
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/wil.jpg'), // Placeholder
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 12),
                const Text(
                  'WILIRAMAYANTI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '1301213012', // NIM placeholder
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. Tab Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: primaryRed,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                tabs: const [
                  Tab(text: 'About Me'),
                  Tab(text: 'Kelas'),
                  Tab(text: 'Edit Profile'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutMeTab(primaryRed),
                _buildKelasTab(),
                _buildEditProfileTab(primaryRed),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: primaryRed,
          indicatorColor: Colors.white.withValues(alpha: 0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return const IconThemeData(color: Colors.white);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _bottomNavIndex,
          onDestinationSelected: (index) {
            if (index == 0) {
              Navigator.of(context).pop(); // Go back to Home
            } else if (index == 1) {
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyClassesScreen()),
              );
            } else if (index == 2) {
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            } else {
              setState(() {
                _bottomNavIndex = index;
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
              icon: Icon(Icons.school_outlined), // Keeping logic consistent
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

  // 4. Tab "About Me"
  Widget _buildAboutMeTab(Color primaryRed) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Email Address', 'wiliramayanti@student.uim.ac.id'),
          _buildInfoRow('Program Studi', 'S1 Informatika'),
          _buildInfoRow('Fakultas', 'Informatika'),
          const SizedBox(height: 24),
          const Text(
            'Aktivitas Login',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          _buildActivityRow('First access to site', 'Monday, 18 August 2021, 10:05 AM'),
          _buildActivityRow('Last access to site', 'Tuesday, 10 December 2024, 08:30 AM'),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Keluar'),
                    content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text('Ya, Keluar', style: TextStyle(color: Color(0xFFB71C1C))),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout, color: Color(0xFFB71C1C)),
              label: const Text('LOG OUT'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFFB71C1C)),
                foregroundColor: const Color(0xFFB71C1C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500)),
          const Divider(height: 20),
        ],
      ),
    );
  }

  Widget _buildActivityRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // 5. Tab "Kelas"
  Widget _buildKelasTab() {
    final courses = [
      {'name': 'Desain Antarmuka & Pengalaman Pengguna', 'code': 'D4SM-42-03', 'date': '18 Des 2024'},
      {'name': 'Pendidikan Kewarganegaraan', 'code': 'D4SM-41-GAB1', 'date': '19 Des 2024'},
      {'name': 'Sistem Operasi', 'code': 'D4SM-44-02', 'date': '20 Des 2024'},
      {'name': 'Pemrograman Perangkat Bergerak', 'code': 'D4SM-41-GAB1', 'date': '21 Des 2024'},
      {'name': 'Bahasa Inggris', 'code': 'D4SM-41-GAB1', 'date': '22 Des 2024'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${course['code']} • Mulai ${course['date']}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }

  // 6. Tab "Edit Profile"
  Widget _buildEditProfileTab(Color primaryRed) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildTextField('Nama Pertama', _firstNameController),
          const SizedBox(height: 16),
          _buildTextField('Nama Terakhir', _lastNameController),
          const SizedBox(height: 16),
          _buildTextField('Email Address', _emailController),
          const SizedBox(height: 16),
          _buildTextField('Negara', _countryController),
          const SizedBox(height: 16),
          _buildTextField('Deskripsi', _descController, maxLines: 3),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                 // Simulate Network Request
                 showDialog(
                   context: context, 
                   barrierDismissible: false,
                   builder: (context) => const Center(child: CircularProgressIndicator())
                 );
                 
                 Future.delayed(const Duration(milliseconds: 1500), () {
                   if (context.mounted) {
                     Navigator.of(context).pop(); // dismiss loading
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profil berhasil diperbarui'),
                        backgroundColor: Colors.green,
                      ),
                    );
                   }
                 });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFB71C1C)),
            ),
          ),
        ),
      ],
    );
  }
}
