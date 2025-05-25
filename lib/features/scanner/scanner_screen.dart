import 'package:flutter/material.dart';
import '../bottom_nav_bar/custom_buttom_navbar.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({
    super.key,
  });

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  // تعريف الميثود onRightSidePressed
  void onRightSidePressed() {
    // هنا يمكنك إضافة أي منطق آخر عند الضغط على الزر العائم
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية الصفحة مع تأثير التعتيم
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/BG.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // المحتوى الرئيسي
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // شريط علوي مثل الهوم
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFEEDBED),
                                    width: 3,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Color(0xFF8852A8),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFEEDBED),
                                    width: 3,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.search,
                                  color: Color(0xFF8852AB),
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: SizedBox(
                            width: 70,
                            height: 40,
                            child: Image.asset(
                              'assets/images/Osp logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'Scanner Page Content Goes Here',
                    style: TextStyle(fontSize: 18, color: Color(0xFF8852A8)),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
