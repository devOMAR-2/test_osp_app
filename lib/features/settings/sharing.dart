import 'package:flutter/material.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppPage extends StatelessWidget {
  const ShareAppPage({super.key});

  final String appLink = 'https://example.com/app-download'; // رابط التطبيق

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            // الخلفية
            SizedBox.expand(
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: 3.1416,
                  child: Image.asset(
                    'assets/images/BG.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // المحتوى
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100), // مكان زر الرجوع
                    const Text(
                      'شارك التطبيق',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0x888852A8),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ادعُ أصدقاءك للاستفادة من ميزات التطبيق عبر مشاركة الرابط على منصات التواصل.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // زر نسخ الرابط
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF52A8A8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.copy, color: Colors.white),
                      label: const Text(
                        'نسخ رابط التطبيق',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Share.share(appLink);
                      },
                    ),
                    const SizedBox(height: 24),

                    // أيقونات المشاركة
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildShareIcon('assets/icons/whatsapp.png', 'واتساب'),
                        _buildShareIcon(
                            'assets/icons/telegram.png', 'تيليجرام'),
                        _buildShareIcon('assets/icons/facebook.png', 'فيسبوك'),
                        _buildShareIcon('assets/icons/twitter.png', 'تويتر'),
                      ],
                    ),
                    const Spacer(),
                    // زر مشاركة عام
                    Center(
                      child: CustomButton(
                        width: 180,
                        height: 50,
                        text: 'مشاركة الآن',
                        onPressed: () {
                          // Share.share(
                          //   'حمل التطبيق الآن من الرابط التالي:\n$appLink',
                          // );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // زر الرجوع
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/back.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareIcon(String assetPath, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0x4DEEDBED),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          // child: Image.asset(assetPath, fit: BoxFit.contain),
          child: Icon(Icons.social_distance_outlined),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
