import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/scanner/image_edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentCameraScreen extends StatefulWidget {
  const DocumentCameraScreen({super.key});

  @override
  State<DocumentCameraScreen> createState() => _DocumentCameraScreenState();
}

class _DocumentCameraScreenState extends State<DocumentCameraScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _capturedImage;

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
            onTap: () async {
              Navigator.pop(context);
              final image =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() => _capturedImage = image);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(AppLocalizations.of(context)!.cameraCap),
            onTap: () async {
              Navigator.pop(context);
              final image = await _picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                setState(() => _capturedImage = image);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E38),
      body: SafeArea(
        child: Stack(
          children: [
            // الخلفية
            if (_capturedImage == null)
              Center(
                  child: Text(
                AppLocalizations.of(context)!.pressCamera,
                style: TextStyle(color: Colors.white70),
              )),

            // زر الرجوع
            Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                child: Image.asset(
                  'assets/images/back.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),

            Positioned(
              bottom: 40,
              right: 40,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.purple, size: 32),
                  onPressed: _showImageSourceDialog,
                ),
              ),
            ),

            // زر الكشف التلقائي (ديكور)
            // Positioned(
            //   bottom: 45,
            //   left: 20,
            //   child: Column(
            //     children: const [
            //       Icon(Icons.grid_view, color: Colors.white, size: 30),
            //       SizedBox(height: 4),
            //       Text(
            //         'الكشف التلقائي',
            //         style: TextStyle(
            //           color: Colors.white70,
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // عرض الصورة الملتقطة
            if (_capturedImage != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(_capturedImage!.path),
                            width: 300,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        width: 180,
                        height: 50,
                        text: AppLocalizations.of(context)!.useImage,
                        onPressed: () async {
                          final editedImage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditImageScreen(
                                imageFile: File(_capturedImage!.path),
                              ),
                            ),
                          );

                          if (editedImage != null && editedImage is File) {
                            setState(() {
                              _capturedImage = XFile(editedImage.path);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      // CustomButton(
                      //   width: 180,
                      //   height: 50,
                      //   text: "إعادة الالتقاط",
                      //   onPressed: () {
                      //     setState(() => _capturedImage = null);
                      //   },
                      // ),
                      TextButton(
                        onPressed: () {
                          setState(() => _capturedImage = null);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.retryCatch,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
