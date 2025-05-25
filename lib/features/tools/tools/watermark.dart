import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/tools/widgets/customappbar.dart';

class WatermarkScreen extends StatefulWidget {
  const WatermarkScreen({super.key, required this.selectedFiles});

  final List<File> selectedFiles;

  @override
  State<WatermarkScreen> createState() => _WatermarkScreenState();
}

class _WatermarkScreenState extends State<WatermarkScreen> {
  final TextEditingController _watermarkController = TextEditingController();

  @override
  void dispose() {
    _watermarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFiles = widget.selectedFiles;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          onBackPressed: () => Navigator.pop(context),
          title: "Watermark",
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // تعليمات وإيقونة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'قم بالسحب و الإفلات لترتيب الصفحات',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xFF8852A8).withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.filter_none,
                          size: 24,
                          color: const Color(0xFF8852A8).withOpacity(0.8),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // حقل إدخال العلامة المائية
                    TextField(
                      controller: _watermarkController,
                      decoration: InputDecoration(
                        labelText: 'أدخل العلامة المائية',
                        labelStyle: const TextStyle(color: Color(0xFF6B46C1)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF6B46C1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // قائمة الملفات
                    selectedFiles.isEmpty
                        ? Column(
                            children: [
                              Image.asset(
                                'assets/images/No_files_Found.png',
                                width: 119,
                                height: 119 / 1.07,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'لا يوجد ملفات !',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B46C1),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: selectedFiles.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  title: Text(
                                    selectedFiles[index].path.split('/').last,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF6B46C1),
                                    ),
                                  ),
                                  leading: const Icon(
                                    Icons.picture_as_pdf,
                                    color: Color(0xFF6B46C1),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),

              // زر أسفل الشاشة
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 180,
                    height: 50,
                    text: "العلامة المائية",
                    onPressed: () {
                      final watermark = _watermarkController.text.trim();
                      if (watermark.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('يرجى إدخال نص العلامة المائية')),
                        );
                        return;
                      }

                      CloudmersiveConverter.addWatermarkToPdf(
                        context: context,
                        filePath: selectedFiles.first.path,
                        watermarkText: watermark,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
