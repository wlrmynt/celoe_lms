import 'package:flutter/material.dart';
import 'package:celoe_lms/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 8. Konsistensi Warna
    const primaryRed = Color(0xFFB71C1C);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // 2. Hero Image & Branding Institusi
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/1.png'), // Full-width building photo
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack( // Overlay for better contrast if needed
                     children: [
                       Container(
                         color: Colors.black.withValues(alpha: 0.2), // Light overlay
                       ),
                       // Logo Tel-U as visual anchor (Top Left as per previous, or center if implied by "Hero & Branding")
                       // The prompt says "logo institusi berbentuk lingkaran dengan warna merah" in the CENTER of transition
                       // We can keep the top-left one if it's strictly required or remove it to focus on the center one.
                       // Based on common designs, a small one top left and main one centered is okay.
                       Positioned(
                         top: 40,
                         left: 20,
                         child: Image.asset(
                           'assets/LogoTel-U 1.png', 
                           height: 40,
                           errorBuilder: (ctx, err, stack) => const SizedBox(),
                         ),
                       ),
                     ],
                  ),
                ),
              ),

              // 7. Footer Decorative Element (Wave)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100,
                child: CustomPaint(
                  painter: WavePainter(color: primaryRed),
                ),
              ),

              // 3. Struktur Form Login
              Positioned(
                top: MediaQuery.of(context).size.height * 0.30, // Overlap slightly or start at 35%
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60), // Space for the floating logo

                      // Judul Halaman
                      const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // 4. Field Input (Email)
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email 365', // Explicit placeholder/label
                          hintText: 'user@student.telkomuniversity.ac.id',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryRed, width: 2),
                          ),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 4. Field Input (Password)
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryRed, width: 2),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // 5. Tombol Login
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      // 6. Tautan Bantuan
                      Center(
                        child: TextButton(
                          onPressed: () {}, // Action for help
                          child: const Text(
                            'Bantuan ?',
                            style: TextStyle(
                              color: primaryRed,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Floating Logo Center (Transition)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.30 - 40, // Half of logo height (80)
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/logo merah.png', // Red circular logo
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 7. Footer Decorative Element (Wave Painter)
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color.withValues(alpha: 0.1) // Light red for wave
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.45, size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.95, size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
    
    // Optional second darker wave
    var paint2 = Paint()
      ..color = color.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;
      
    var path2 = Path();
    path2.moveTo(0, size.height * 0.7);
    path2.quadraticBezierTo(
        size.width * 0.25, size.height * 0.8, size.width * 0.5, size.height * 0.6);
     path2.quadraticBezierTo(
        size.width * 0.75, size.height * 0.4, size.width, size.height * 0.8);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
