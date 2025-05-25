import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/ocr/extracted_text_screen.dart';

class ArabicOcrScreen extends StatefulWidget {
  final File? imageFile;
  const ArabicOcrScreen({Key? key, this.imageFile}) : super(key: key);

  @override
  State<ArabicOcrScreen> createState() => _ArabicOcrScreenState();
}

class _ArabicOcrScreenState extends State<ArabicOcrScreen> {
  File? _imageFile; // ✅ تعريف المتغير هنا
  bool _isLoading = false;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile; // ✅ تهيئة المتغير من الباراميتر
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _performOcrAndNavigate() async {
    if (_imageFile != null) {
      setState(() => _isLoading = true);

      try {
        final text = await FlutterTesseractOcr.extractText(
          _imageFile!.path,
          language: 'ara+eng',
          args: {
            'psm': '4',
            'tessdata': 'assets/tessdata',
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
            title: const Text('اختر من المعرض'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('التقاط بالكاميرا'),
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
                          label: const Text('اختر صورة',
                              style: TextStyle(fontSize: 20)),
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
                                text: 'تحليل الصورة',
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
