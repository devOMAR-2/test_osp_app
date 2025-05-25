import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // ← اجعل العنوان اختياري
  final VoidCallback onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: Colors.transparent, // Removed background color
        elevation: 0, // Optionally set elevation to 0 for no shadow
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // لضمان محاذاة العناصر في الصف
          children: [
            // العنوان في أقصى اليمين
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                title,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Color(0xD78852A8),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            // زر العودة في أقصى اليسار
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                'assets/images/back.png',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
