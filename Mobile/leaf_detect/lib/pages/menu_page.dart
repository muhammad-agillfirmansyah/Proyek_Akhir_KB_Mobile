import 'package:flutter/material.dart';
import 'menu_informasi.dart';
import 'menu_cek.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

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
              const Color(0xFF65D0C7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logo_menu.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    // App name
                    // const Text(
                    //   'LeafDetect',
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black87,
                    //   ),
                    // ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Menu cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Card 1: Informasi Penyakit
                      _buildMenuCard(
                        context: context,
                        icon: 'assets/images/leaf_info.png',
                        title: 'Informasi Penyakit\nDaun Singkong',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuInformasi(),
                            ),
                          );
                        },
                      ),
                                            
                      const SizedBox(height: 30),
                      
                      // Card 2: Cek Daun Singkong
                      _buildMenuCard(
                        context: context,
                        icon: 'assets/images/leaf_check.png',
                        title: 'Cek Daun Singkong',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuCek(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Icon/Image
            Image.asset(
              icon,
              width: 120,
              height: 120,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder if image not found
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.eco,
                    size: 50,
                    color: Colors.green.shade700,
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}