import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String image;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 125,
        height: 120,
        child: Stack(
          alignment: Alignment.center, // توسيط العناصر داخل الستاك
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 243, 243),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Color(0xFFF5F5F9),
                    // Color(0xFFEEDBED),
                    Colors.white,

                    Color(0xFFEEDBED),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8852A8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(height: 60, child: Image.asset(image)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
