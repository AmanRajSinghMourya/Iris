import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris/utilities/button_widget.dart';
import 'package:iris/utilities/constants.dart';
import 'package:iris/utilities/strings.dart';
import 'package:iris/views/detail_form.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          scanCard,
          style: kButtonStyle(),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<File?>(
                valueListenable: _imageFile,
                builder: (context, file, _) {
                  return Card(
                    color: cardBackgroundColor,
                    elevation: 2,
                    child: SizedBox(
                      height: size.height * 0.3,
                      child: Center(
                        child: file == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _pickImage(ImageSource.camera);
                                      },
                                      child: Icon(
                                        Icons.camera,
                                        size: 30,
                                        color: kIconColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _pickImage(ImageSource.gallery);
                                      },
                                      child: Icon(
                                        Icons.image,
                                        size: 30,
                                        color: kIconColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.01),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailForm(cardData: extractText.value),
                    ),
                  );
                },
                width: double.infinity,
                child: ValueListenableBuilder<String>(
                  valueListenable: extractText,
                  builder: (context, text, _) {
                    return Text(
                      text.isEmpty ? skip : Continue,
                      style: kButtonStyle(),
                    );
                  },
                ),
              ),

              /// Extracted Text
              SizedBox(
                height: size.height * 0.01,
              ),
              Card(
                color: cardBackgroundColor,
                elevation: 2,
                child: SizedBox(
                    height: size.height * 0.4,
                    child: ValueListenableBuilder<String>(
                      valueListenable: extractText,
                      builder: (context, text, _) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Text(
                              text.isEmpty ? pleaseScanCard : text,
                              style: kHintTextStyle(),
                            ),
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
