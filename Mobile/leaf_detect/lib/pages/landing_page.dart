import 'package:flutter/material.dart';
import 'menu_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 101, 208, 199),
              const Color(0xFF5DD9C1).withOpacity(0.8),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative circle at bottom right
            Positioned(
              bottom: -100,
              right: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 96, 91, 91).withOpacity(0.1),
                ),
              ),
            ),
            
            Column(
              children: [
                // Logo and title
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo image
                      Image.asset(
                        'assets/images/logo_menu.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                
                // White bottom section with curved effect
                ClipPath(
                  clipper: PointedCornerClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 80, 30, 30),
                      child: Column(
                        children: [
                          // Description text
                          const Text(
                            'Aplikasi Pendeteksi Penyakit\nDaun Singkong',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 60),
                          
                          // Start button - Navigate to Menu Page
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MenuPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00BFA5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Mulai',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper for curved effect like in the design
class PointedCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start from bottom left
    path.moveTo(0, size.height);
    
    // Left side going up
    path.lineTo(0, 80);
    
    // Create large curve from top-left to right side
    // This creates the diagonal curved effect
    path.quadraticBezierTo(
      size.width * 0.3,  // Control point X (30% from left)
      -20,               // Control point Y (above the top)
      size.width,        // End point X (right edge)
      size.height * 0.4, // End point Y (40% down from top)
    );
    
    // Right side going down
    path.lineTo(size.width, size.height);
    
    // Bottom side
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}