import 'package:flutter/material.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/ocr/arabic_doc.dart';
import 'package:osp/features/ocr/english_doc.dart';
import '../bottom_nav_bar/custom_buttom_navbar.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({super.key});

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/BG.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  // height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Container(
                      //     width: 50,
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //           color: Color(0xFFEEDBED), width: 3),
                      //     ),
                      //     child: GestureDetector(
                      //       onTap: () => Navigator.pop(context),
                      //       child: const Icon(Icons.arrow_back,
                      //           size: 25, color: Color(0xFF8852A8)),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          child: Image.asset(
                            'assets/images/back.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
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
                const SizedBox(height: 20),
                const Text(
                  'OCR Page',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8852A8)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'هنا سيتم معالجة الصور عبر التعرف الضوئي على الحروف (OCR)',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 60),
                const SizedBox(height: 30),
                CustomButton(
                  text: "مستند عربي",
                  width: 230,
                  height: 70,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArabicOcrScreen()),
                    );
                  },
                  // textColor: ,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: "English Document",
                  width: 230,
                  height: 70,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnglishOcrScreen()),
                    );
                  },
                  // textColor: ,
                ),
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
