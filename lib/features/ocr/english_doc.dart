import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/ocr/extracted_text_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnglishOcrScreen extends StatefulWidget {
  final File? imageFile;
  const EnglishOcrScreen({super.key, this.imageFile});

  @override
  State<EnglishOcrScreen> createState() => _EnglishOcrScreenState();
}

class _EnglishOcrScreenState extends State<EnglishOcrScreen> {
  File? _imageFile;
  bool _isLoading = false;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile; // ✅ التهيئة من الباراميتر
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _copyTessData() async {
    final dir = await getApplicationDocumentsDirectory();
    final tessdataPath = '${dir.path}/tessdata';
    final trainedDataPath = '$tessdataPath/eng.traineddata';

    final tessdataDir = Directory(tessdataPath);
    if (!await tessdataDir.exists()) {
      await tessdataDir.create(recursive: true);
    }

    final trainedDataFile = File(trainedDataPath);
    if (!await trainedDataFile.exists()) {
      final byteData = await rootBundle.load('assets/tessdata/eng.traineddata');
      await trainedDataFile.writeAsBytes(byteData.buffer.asUint8List());
    }

    return dir.path;
  }

  Future<void> _performOcrAndNavigate() async {
    if (_imageFile != null) {
      setState(() => _isLoading = true);

      try {
        final tessDir = await _copyTessData();

        final text = await FlutterTesseractOcr.extractText(
          _imageFile!.path,
          language: 'eng',
          args: {
            'tessdata': '$tessDir/tessdata',
          },
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OcrResultScreen(extractedText: text),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("خطأ أثناء التحليل: $e")),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(AppLocalizations.of(context)!.chooseFromGallary),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(AppLocalizations.of(context)!.cameraCap),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/images/BG.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      'assets/images/back.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          onPressed: _showImageSourceDialog,
                          icon: const Icon(Icons.add_a_photo, size: 30),
                          label: Text(
                            AppLocalizations.of(context)!.chooseImage,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_imageFile != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              _imageFile!,
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 24),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                text:
                                    AppLocalizations.of(context)!.analysisImage,
                                width: 200,
                                height: 50,
                                onPressed: _performOcrAndNavigate,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
