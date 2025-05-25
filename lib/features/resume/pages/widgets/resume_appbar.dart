import 'package:flutter/material.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ResumeAppbar extends StatelessWidget {
  String name;
  ResumeAppbar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              name,
              style: TextStyle(
                  // color: Color(0xFF8852A8),
                  color: themeProvider.isDarkMode
                      ? Color(0xFFEEDBED)
                      : Color(0xFF8852A8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
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
        ],
      ),
    );
  }
}
