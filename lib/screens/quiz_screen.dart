import 'package:flutter/material.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  Timer? _timer;
  int _timeLeft = 900; // 15 minutes in seconds
  List<int?> _selectedAnswers = List.generate(15, (index) => null);
  final List<bool> _isCorrect = List.generate(15, (index) => false); // Track correctness for bubbles

  // Mock Question Data
  final Map<String, dynamic> _currentQuestion = {
    'question': 'Apa tujuan utama dari User Interface (UI) Design?',
    'options': [
      'Membuat kode program yang efisien',
      'Membuat tampilan yang menarik dan mudah digunakan',
      'Mengelola basis data pengguna',
      'Menulis dokumentasi teknis sistem',
    ],
    'correctIndex': 1,
  };

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        // Handle timeout
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _handleAnswer(int index) {
    if (_selectedAnswers[_currentQuestionIndex] != null) return; // Prevent changing answer

    setState(() {
      _selectedAnswers[_currentQuestionIndex] = index;
      if (index == _currentQuestion['correctIndex']) {
        _isCorrect[_currentQuestionIndex] = true;
      } else {
        _isCorrect[_currentQuestionIndex] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Quiz Review 01',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header: Timer & Progress Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(_timeLeft),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Soal Nomor ${_currentQuestionIndex + 1} / 15',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Navigation Bubbles
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return _buildNavBubble(index);
                },
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Text(
              _currentQuestion['question'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Answer Options
            Expanded(
              child: ListView.separated(
                itemCount: _currentQuestion['options'].length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildAnswerOption(index, _currentQuestion['options'][index]);
                },
              ),
            ),

            // Footer: Lanjut Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   setState(() {
                     if (_currentQuestionIndex < 14) {
                       _currentQuestionIndex++;
                       // Note: In a real app, we would load the next question data here
                     } else {
                       // Finish Quiz
                       Navigator.of(context).pop();
                     }
                   });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex == 14 ? 'Selesai' : 'Lanjut',
                   style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                     color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBubble(int index) {
    Color borderColor = Colors.grey;
    Color? fillColor;
    Color textColor = Colors.black;

    // Logic for styling based on state
    if (index == _currentQuestionIndex) {
      borderColor = Colors.blue;
      textColor = Colors.blue;
    } 
    
    if (_selectedAnswers[index] != null) {
      if (_isCorrect[index]) {
        fillColor = Colors.green;
        borderColor = Colors.green;
        textColor = Colors.white;
      } else {
        fillColor = Colors.red;
         borderColor = Colors.red;
        textColor = Colors.white;
      }
    }

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: fillColor ?? Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        '${index + 1}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnswerOption(int index, String text) {
    Color borderColor = Colors.grey.shade300;
    Color?  fillColor = Colors.white;
    Color textColor = Colors.black87;

    // Feedback Logic
    if (_selectedAnswers[_currentQuestionIndex] != null) {
      if (index == _currentQuestion['correctIndex']) {
        // Correct Answer (Standard: Green)
        borderColor = Colors.green;
        fillColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
      } else if (index == _selectedAnswers[_currentQuestionIndex]) {
        // Selected Wrong Answer (Red)
        borderColor = Colors.red;
         fillColor = Colors.red.withValues(alpha: 0.1);
         textColor = Colors.red;
      }
    }

    return InkWell(
      onTap: () => _handleAnswer(index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 border: Border.all(color: borderColor),
                 color: _selectedAnswers[_currentQuestionIndex] == index ? borderColor : Colors.transparent,
              ),
              child: Text(
                String.fromCharCode(65 + index), // A, B, C, D
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: _selectedAnswers[_currentQuestionIndex] == index ? Colors.white : textColor,
                ),
              ),
            ),
             const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
