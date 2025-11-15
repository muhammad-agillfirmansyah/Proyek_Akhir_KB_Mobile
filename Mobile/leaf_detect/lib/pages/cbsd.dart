import 'package:flutter/material.dart';

class Cbsd extends StatelessWidget {
  const Cbsd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF65D0C7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //  HEADER 
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    // Tombol Kembali
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Color(0xFF124628)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    // Logo + Judul
                    Image.asset(
                      'assets/images/leaf_info.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Informasi Penyakit Daun Singkong',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF124628),
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //  BOX JUDUL Cbsd 
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Virus Garis Cokelat Singkong',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF124628),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //  BOX PENJELASAN 
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Subjudul 1
                    Text(
                      'Penyebab',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Virus Cassava brown streak virus dan Ugandan cassava brown streak virus yang ditularkan oleh kutu putih.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                    SizedBox(height: 25),

                    // Subjudul 2 
                    Text(
                      'Gejala',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Muncul garis atau bercak cokelat kekuningan pada tulang daun.\n'
                      '• Daun menjadi mengerut atau melengkung ke bawah.\n'
                      '• Batang dan akar membusuk dengan garis cokelat di dalam umbi.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                    SizedBox(height: 25),

                    // Subjudul 3
                    Text(
                      'Dampak',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Penurunan kualitas dan kuantitas umbi singkong — bahkan kehilangan hasil panen hingga 70%.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                    SizedBox(height: 25),

                    // Subjudul 4
                    Text(
                      'Pencegahan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Gunakan bibit tahan penyakit (varietas resisten CBSV).\n'
                      '• Hindari penanaman di daerah endemik.\n'
                      '• Kendalikan kutu putih pembawa virus.\n'
                      '• Singkirkan tanaman yang terinfeksi untuk mencegah penyebaran.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
