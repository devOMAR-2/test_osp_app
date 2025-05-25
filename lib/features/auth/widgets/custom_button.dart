// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final double width;
//   final double height;
//   final String text;
//   final VoidCallback? onPressed;
//   final Color? color;
//   final Color? textColor;

//   const CustomButton({
//     super.key, // استخدام Key بشكل صحيح هنا
//     required this.width,
//     required this.height,
//     required this.text,
//     required this.onPressed,
//     this.color,
//     this.textColor,
//   }); // تأكد من تمرير key إلى super

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         gradient: const LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.white,
//             Color(0xFFEEDBED),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(16),
//           child: Stack(
//             children: [
//               // Border layer with shadow effect
//               Positioned(
//                 top: 2,
//                 left: 6,
//                 child: Container(
//                   width: width - 12,
//                   height: height - 3,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: const Color(0x4D8852A8),
//                       width: 1,
//                     ),
//                   ),
//                 ),
//               ),
//               // Button text in the center
//               Center(
//                 child: Text(
//                   text,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: Color(0xCC8852A8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0x4D8852A8),
          width: 2,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEEDBED),
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Button text
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor ?? const Color(0xCC8852A8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
