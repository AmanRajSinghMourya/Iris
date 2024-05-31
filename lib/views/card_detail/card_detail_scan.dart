import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris/utilities/constants.dart';
import 'package:iris/utilities/strings.dart';

class CardDetailScan extends StatefulWidget {
  const CardDetailScan({super.key});

  @override
  State<CardDetailScan> createState() => _CardDetailScanState();
}

class _CardDetailScanState extends State<CardDetailScan> {
  final ValueNotifier<File?> _imageFile = ValueNotifier<File?>(null);
  final ValueNotifier<String> extractText = ValueNotifier<String>("");
  final ImagePicker imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      _imageFile.value = File(pickedImage.path);
      await _processImage(_imageFile.value!);
    }
  }

  Future<void> _processImage(File imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);
    extractText.value = recognizedText.text;
    print(extractText.value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Center(
              child: Text(
                pleaseScanCard,
                style: kLoginTermsAndPrivacyStyle(size),
                textAlign: TextAlign.center,
              ),
            ),
            ValueListenableBuilder<File?>(
              valueListenable: _imageFile,
              builder: (context, file, _) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Card(
                    color: cardBackgroundColor,
                    elevation: 2,
                    child: SizedBox(
                      height: 400,
                      child: Center(
                        child: file == null
                            ? Text(
                                pleaseSelectAnImage,
                                style: kLoginOrSignUpTextStyle(size),
                              )
                            : Image.network(file.toString()),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      cardBackgroundColor,
                    ),
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: Text(
                    gallery,
                    style: kLoginTitleStyle(size),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      cardBackgroundColor,
                    ),
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Text(
                    camera,
                    style: kLoginTitleStyle(size),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: extractText,
              builder: (context, text, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: kHaveAnAccountStyle(size),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
