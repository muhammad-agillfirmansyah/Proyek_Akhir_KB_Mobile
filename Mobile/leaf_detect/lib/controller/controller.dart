  import 'dart:convert';
  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:image_picker/image_picker.dart';

  class PredictionProvider with ChangeNotifier {
    File? imageFile;
    String? predictionLabel;
    double? predictionConfidence;

    final ImagePicker _picker = ImagePicker();

    // Pick Image
    Future<void> pickImage(ImageSource source) async {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        notifyListeners();
      }
    }

    // Predict Image Using Django API
    Future<void> predictImage() async {
      if (imageFile == null) return;

      final url = Uri.parse('http://192.168.1.12:8000/api/predict-image');


    final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile!.path));


      try {
        final response = await request.send();
        final responseData = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          final data = jsonDecode(responseData);

          predictionLabel = data['label'];
            predictionConfidence =
                data.containsKey('confidence')
                    ? double.tryParse(data['confidence'].toString())
                    : null;


        } else {
          predictionLabel = "Error";
          predictionConfidence = 0;
        }
      } catch (e) {
        predictionLabel = "Error: $e";
        predictionConfidence = 0;
      }

      notifyListeners();
    }

    // Clear
    void clear() {
      imageFile = null;
      predictionLabel = null;
      predictionConfidence = null;
      notifyListeners();
    }
  }
