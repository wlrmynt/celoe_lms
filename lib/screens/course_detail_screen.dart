import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/meeting_detail_screen.dart';
import 'package:celoe_lms/screens/quiz_screen.dart';
import 'package:celoe_lms/screens/assignment_detail_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseName;

  const CourseDetailScreen({super.key, required this.courseName});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          widget.courseName,
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
          isScrollable: true,
          tabs: const [
            Tab(text: 'Materi'),
            Tab(text: 'Tugas Dan Kuis'),
            Tab(text: 'Tools'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Materi (Meetings List)
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 4, // Showing 4 meetings for demo
            itemBuilder: (context, index) {
              return _buildMeetingItem(index + 1);
            },
          ),

          // Tab 2: Tugas Dan Kuis
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildTaskItem('Quiz 1: Konsep Dasar UI', 'Deadline: 26 Feb 2021, 23:59', true),
              const SizedBox(height: 12),
              _buildTaskItem('Tugas Besar 1: Wireframing', 'Deadline: 15 Mar 2021, 23:59', false),
              const SizedBox(height: 12),
              _buildTaskItem('Quiz 2: Color Theory', 'Deadline: 30 Mar 2021, 23:59', false),
            ],
          ),

          // Tab 3: Tools
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildToolItem('Figma', 'Desain Interface & Prototyping', 'assets/UX.png'),
              const SizedBox(height: 12),
              _buildToolItem('Visual Studio Code', 'Code Editor', 'assets/1.png'),
              const SizedBox(height: 12),
              _buildToolItem('Trello', 'Manajemen Proyek', 'assets/Learning Management System.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingItem(int meetingNumber) {
    // Accordion style item
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFB71C1C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Pertemuan $meetingNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            title: Text(
              meetingNumber == 1 ? 'Pengantar User Interface Design' : 'Topik Pertemuan $meetingNumber',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            children: [
              // Content inside accordion
              InkWell(
                onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MeetingDetailScreen(
                        meetingTitle: meetingNumber == 1 
                            ? 'Pengantar User Interface Design' 
                            : 'Topik Pertemuan $meetingNumber'
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10, bottom: 20, right: 16),
                  child: Row(
                    children: [
                       Expanded(
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '01 - ${meetingNumber == 1 ? 'Pengantar UI Design' : 'Materi $meetingNumber'}',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                             const Text(
                              '3 URLS, 2 Files, 1 Quiz',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                         ),
                       ),
                       const Icon(Icons.check_circle, color: Colors.green, size: 20),
                       const SizedBox(width: 8),
                       const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTaskItem(String title, String deadline, bool isCompleted) {
    return GestureDetector(
      onTap: () {
        if (title.contains('Quiz')) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const QuizScreen()),
          );
        } else if (title.contains('Tugas')) {
           Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AssignmentDetailScreen(assignmentTitle: title)),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.assignment_outlined, color: Colors.orange),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deadline,
                    style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildToolItem(String name, String description, String assetPath) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Membuka tool $name...')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withValues(alpha: 0.05),
               blurRadius: 4,
               offset: const Offset(0, 2),
             ),
          ],
        ),
        child: Row(
          children: [
             Container(
               width: 50,
               height: 50,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(8),
                 color: Colors.grey[100],
                 image: DecorationImage(
                    image: AssetImage(assetPath),
                    fit: BoxFit.cover,
                 )
               ),
             ),
             const SizedBox(width: 16),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                   const SizedBox(height: 4),
                   Text(description, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                 ],
               ),
             ),
             const Icon(Icons.open_in_new, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
