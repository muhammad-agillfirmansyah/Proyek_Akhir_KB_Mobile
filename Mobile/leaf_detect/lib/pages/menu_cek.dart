import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:leaf_detect/controller/controller.dart';
import 'package:leaf_detect/pages/hasil_analisis.dart';

class MenuCek extends StatefulWidget {
  const MenuCek({super.key});

  @override
  State<MenuCek> createState() => _MenuCekState();
}

class _MenuCekState extends State<MenuCek> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF15B7B9);
    final provider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF65D0C7),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Color(0xFF124628)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/leaf_check.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Cek Daun Singkong',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF124628),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // PREVIEW GAMBAR
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: _imageFile == null
                  ? const Center(
                      child: Text(
                        'Belum Ada Gambar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _imageFile!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // PETUNJUK
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terdapat dua cara mengambil gambar:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '1. Gunakan kamera.\n'
                    '2. Pilih dari galeri.\n'
                    '3. Tekan “Hasil Analisis” untuk melihat prediksi AI.',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // TOMBOL AMBIL GAMBAR & GALERI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _getImageFromGallery,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child:
                          const Icon(Icons.photo_library, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _getImageFromCamera,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Ambil Gambar',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TOMBOL HASIL ANALISIS (PANGGIL AI)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                      print("Button clicked");

                    if (_imageFile == null) {
                          print("Image not selected");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Silakan ambil atau pilih gambar terlebih dahulu.'),
                        ),
                      );
                      return;
                    }

                    provider.imageFile = _imageFile;
                    await provider.predictImage();

                    if (provider.predictionLabel != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HasilAnalisis(
                            imageFile: _imageFile!,
                            label: provider.predictionLabel!,
                            confidence: provider.predictionConfidence,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Hasil Analisis',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}