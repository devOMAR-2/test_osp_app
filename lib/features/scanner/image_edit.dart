import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:share_plus/share_plus.dart'; // NEW

class EditImageScreen extends StatefulWidget {
  final File imageFile;
  const EditImageScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  late File editedImage;

  @override
  void initState() {
    super.initState();
    editedImage = widget.imageFile;
  }

  void _openEditor() async {
    final edited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: widget.imageFile.readAsBytesSync(),
        ),
      ),
    );

    if (edited != null && edited is Uint8List) {
      setState(() {
        editedImage = File('${Directory.systemTemp.path}/edited_image.jpg')
          ..writeAsBytesSync(edited);
      });
    }
  }

  // NEW: وظيفة المشاركة
  Future<void> _shareImage() async {
    // // لو Android 13+ نطلب صلاحية مؤقتة لقراءة الوسائط
    // if (Platform.isAndroid && await Permission.photos.request().isDenied) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("⚠️ يجب منح صلاحية الوصول للصور")),
    //   );
    //   return;
    // }

    if (await editedImage.exists()) {
      await Share.shareXFiles(
        [XFile(editedImage.path)],
        text: 'صوري بعد التعديل 📷',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ تعذر العثور على الملف لمشاركته")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF2C2C2C),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.file(editedImage),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: const Color(0xFF1E1E1E),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: _openEditor,
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, // NEW
                            color: Color(0xFF8852A8)),
                        onPressed: _shareImage, // NEW
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
