import 'package:flutter/material.dart';

class AssignmentDetailScreen extends StatefulWidget {
  final String assignmentTitle;

  const AssignmentDetailScreen({super.key, required this.assignmentTitle});

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  String? _selectedFileName;
  bool _isUploading = false;

  void _pickFile() async {
    setState(() {
      _isUploading = true;
    });

    // Simulate file picking delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _selectedFileName = "Tugas_Konsep_UI_Wiliramayanti.zip";
      _isUploading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File berhasil dipilih'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _submitAssignment() {
    if (_selectedFileName == null) return;

    // Simulate submission
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
         Navigator.of(context).pop(); // Dismiss loading
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tugas berhasil dikumpulkan!')),
        );
        Navigator.of(context).pop(); // Go back
      }
    });
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
        title: Text(
          widget.assignmentTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions Section
            const Text(
              'Instruksi Tugas:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildInstructionItem(1, 'Buatlah desain High-Fidelity untuk aplikasi Mobile Banking.'),
            _buildInstructionItem(2, 'Gunakan color palette yang konsisten.'),
            _buildInstructionItem(3, 'Terapkan prinsip Gestalt dalam tata letak.'),
            _buildInstructionItem(4, 'Kumpulkan dalam format .zip berisi file desain dan aset.'),
            const SizedBox(height: 24),

            // Status Section
            const Text(
              'Status Pengumpulan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildStatusRow('Status Pengumpulan:', _selectedFileName != null ? 'Sudah dikumpulkan' : 'Belum dikumpulkan', _selectedFileName != null ? Colors.green : Colors.grey),
                  const Divider(height: 1),
                  _buildStatusRow('Status Penilaian:', 'Belum dinilai', Colors.grey),
                  const Divider(height: 1),
                  _buildStatusRow('Tenggat Waktu:', 'Senin, 15 Mar 2021, 23:59 WIB', Colors.black87),
                  const Divider(height: 1),
                  _buildStatusRow('Sisa Waktu:', '6 Jam 30 Menit', Colors.red, isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submission Form
             const Text(
              'Pengumpulan Tugas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
             const SizedBox(height: 12),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: Colors.grey[400]!, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _isUploading 
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(
                     _selectedFileName != null ? Icons.check_circle_outline : Icons.cloud_upload_outlined, 
                     size: 48, 
                     color: _selectedFileName != null ? Colors.green : Colors.grey[400]
                   ),
                   const SizedBox(height: 16),
                   Text(
                     _selectedFileName ?? 'Drag & Drop file di sini atau',
                     style: TextStyle(color: _selectedFileName != null ? Colors.black87 : Colors.grey, fontWeight: _selectedFileName != null ? FontWeight.bold : FontWeight.normal),
                   ),
                   const SizedBox(height: 12),
                   if (_selectedFileName == null)
                     ElevatedButton(
                       onPressed: _pickFile,
                       style: ElevatedButton.styleFrom(
                         backgroundColor: primaryRed,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8),
                         ),
                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                       ),
                       child: const Text('Pilih File', style: TextStyle(color: Colors.white)),
                     ),
                   const SizedBox(height: 12),
                    const Text(
                     'Maks. Ukuran File: 100MB, Maks. Jumlah File: 1',
                     style: TextStyle(color: Colors.grey, fontSize: 12),
                   ),
                 ],
              ),
            ),
             const SizedBox(height: 24),
             SizedBox(
               width: double.infinity,
               height: 50,
               child: ElevatedButton(
                 onPressed: _selectedFileName != null ? _submitAssignment : null, // Disable if no file
                 style: ElevatedButton.styleFrom(
                   backgroundColor: primaryRed,
                   disabledBackgroundColor: Colors.grey[300],
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                 ),
                 child: const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
               ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number. ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, Color valueColor, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
