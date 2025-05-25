import 'dart:io';
import 'package:flutter/material.dart';

class DocumentSignScreen extends StatelessWidget {
  final List<File> selectedFiles;
  const DocumentSignScreen({super.key, required this.selectedFiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('توقيع المستند'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'الملفات المحددة: ${selectedFiles.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // أضف هنا الكود الخاص بتوقيع المستند
              },
              child: const Text('توقيع المستند'),
            ),
          ],
        ),
      ),
    );
  }
}
