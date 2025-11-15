import 'dart:io';
import 'package:flutter/material.dart';

class HasilAnalisis extends StatelessWidget {
  final File imageFile;
  final String label;
  final double? confidence;

  const HasilAnalisis({
    super.key,
    required this.imageFile,
    required this.label,
    this.confidence,
  });

  // ✨ MAPPING NAMA CLASS KE NAMA TAMPILAN
  static const Map<String, Map<String, dynamic>> labelMapping = {
    // Class dari model
    'Cassava_bacterial_blight': {
      'display': 'Hawar Daun Bakteri',
      'description': 'Daun terserang bakteri yang menyebabkan bercak coklat',
      'severity': 'Serius',
      'color': Colors.red,
    },
    'Cassava_healthy': {
      'display': 'Daun Sehat',
      'description': 'Daun singkong dalam kondisi sehat dan normal',
      'severity': 'Normal',
      'color': Colors.green,
    },
    'Cassava_mosaic_disease': {
      'display': 'Penyakit Mosaik',
      'description': 'Daun terserang virus mosaik',
      'severity': 'Serius',
      'color': Colors.orange,
    },
    
    // Edge cases
    'Bukan Daun Singkong': {
      'display': 'Bukan Daun Singkong',
      'description': 'Gambar yang dianalisis bukan daun singkong',
      'severity': 'Info',
      'color': Colors.grey,
    },
    'tidak dikenali': {
      'display': 'Tidak Dikenali',
      'description': 'Sistem tidak dapat mengenali dengan pasti',
      'severity': 'Info',
      'color': Colors.grey,
    },
  };

  // Helper method untuk mendapatkan display name
  String getDisplayName(String rawLabel) {
    if (labelMapping.containsKey(rawLabel)) {
      return labelMapping[rawLabel]!['display'];
    }
    
    // case-insensitive match
    final lowerLabel = rawLabel.toLowerCase();
    for (var entry in labelMapping.entries) {
      if (entry.key.toLowerCase() == lowerLabel) {
        return entry.value['display'];
      }
    }
    
    // Fallback ke raw label kalau tidak ada mapping
    return rawLabel;
  }

  // Helper untuk mendapatkan info tambahan
  Map<String, dynamic>? getLabelInfo(String rawLabel) {
    if (labelMapping.containsKey(rawLabel)) {
      return labelMapping[rawLabel];
    }
    
    // Case-insensitive match
    final lowerLabel = rawLabel.toLowerCase();
    for (var entry in labelMapping.entries) {
      if (entry.key.toLowerCase() == lowerLabel) {
        return entry.value;
      }
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF15B7B9);
    
    final displayName = getDisplayName(label);
    final labelInfo = getLabelInfo(label);
    final lowerLabel = label.toLowerCase().trim();
    
    // Tentukan apakah confidence perlu ditampilkan
    final showConfidence = confidence != null && 
        !(lowerLabel.contains("bukan daun singkong") ||
          lowerLabel.contains("tidak dikenali"));

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
                      'Hasil Analisis',
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

            // GAMBAR
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // HASIL TEKS
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil Analisis Daun Singkong:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF124628),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // ✨ DISPLAY NAME dengan warna badge
                  Row(
                    children: [
                      const Text(
                        'Kondisi: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: labelInfo?['color']?.withOpacity(0.1) ?? 
                                   Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: labelInfo?['color'] ?? Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: labelInfo?['color'] ?? Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Confidence
                  if (showConfidence) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Tingkat Keyakinan: ${(confidence! * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],

                  // Deskripsi tambahan
                  if (labelInfo?['description'] != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              labelInfo!['description'],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue.shade900,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 25),

            // BUTTON ULANGI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Ulangi Analisis',
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