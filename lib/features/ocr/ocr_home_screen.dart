import 'package:flutter/material.dart';
import 'package:osp/features/ocr/arabic_doc.dart';
import 'package:osp/features/ocr/english_doc.dart';
import '../bottom_nav_bar/custom_buttom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OcrHomeScreen extends StatelessWidget {
  const OcrHomeScreen({super.key});

  void onRightSidePressed() {
    print('Right side pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Center(
                child: _buildTapableCard(context),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ],
        ),
      ),
      floatingActionButton: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(
              'assets/images/Osp logo.png',
              width: 70,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTapableCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentLocale = AppLocalizations.of(context)!.localeName;
        if (currentLocale == 'ar') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ArabicOcrScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EnglishOcrScreen()),
          );
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/Rectangle 32.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.osr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8852A8),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
