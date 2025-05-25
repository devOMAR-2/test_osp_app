import 'dart:io';
import 'package:flutter/material.dart';

class FileItemWidget extends StatelessWidget {
  final FileSystemEntity file;
  const FileItemWidget({super.key, required this.file});  // استخدام Key بشكل صحيح

  @override
  Widget build(BuildContext context) {
    String fileName = file.uri.pathSegments.last;
    String fileDate = 'غير معروف';  // Default value in case of failure to fetch file modification date

    try {
      fileDate = file.statSync().modified.toString();
    } catch (e) {
      print('Error fetching file stats: $e');
    }

    return ListTile(
      leading: const Icon(Icons.insert_drive_file, color: Colors.purple),
      title: Text(fileName),
      subtitle: Text(fileDate),
      trailing: IconButton(
        icon: const Icon(Icons.favorite_border),
        onPressed: () {
          // إضافة لائحة المفضلة هنا
        },
      ),
      onTap: () {
        // تعامل مع الضغط على الملف هنا
      },
    );
  }
}
