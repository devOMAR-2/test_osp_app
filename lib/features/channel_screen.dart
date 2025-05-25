import 'package:flutter/material.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});  // استخدام Key بشكل صحيح

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القناة'),
        backgroundColor: const Color(0xFF8852AB), // يمكنك تعديل اللون حسب التصميم
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'قائمة القنوات:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // يمكن إضافة قائمة أو أي نوع آخر من المحتوى هنا
            Expanded(
              child: ListView.builder(
                itemCount: 10, // عدد القنوات
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.tv, color: Color(0xFF8852AB)), // أيقونة القناة
                      title: Text('قناة ${index + 1}'),
                      subtitle: Text('وصف القناة رقم ${index + 1}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // إضافة الوظيفة عند الضغط على القناة
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
