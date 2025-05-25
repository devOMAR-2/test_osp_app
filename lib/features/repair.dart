import 'dart:io';
import 'package:flutter/material.dart';

class DocumentRepairScreen extends StatelessWidget {
  final List<File> selectedFiles;
  const DocumentRepairScreen({super.key, required this.selectedFiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إصلاح مستند'),
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
                // أضف هنا الكود الخاص بإصلاح المستند
              },
              child: const Text('إصلاح المستند'),
            ),
          ],
        ),
      ),
    );
  }
}
