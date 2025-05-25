import 'package:flutter/material.dart';
import 'package:osp/features/home/home_screen.dart';
import 'package:osp/features/ocr/ocr_home_screen.dart';
import 'package:osp/features/scanner/scanner_page.dart';
import 'package:osp/features/settings/settings.dart';
import 'dart:math';
import '../tools/tools_screen.dart';
import '../resume/cv_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _controller;
  int selectedIndex = 1; // 0 = settings, 1 = home

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  Widget buildCurvedOption(
      String asset, int index, int total, VoidCallback onTap) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.value == 0) return const SizedBox.shrink();

        final angleStep = pi / (total - 1);
        final angle = angleStep * index;
        final radius =
            MediaQuery.of(context).size.width * 0.2 * _controller.value;

        final dx = radius * cos(angle);
        final dy = radius * sin(angle);

        return Positioned(
          bottom: 60 + dy,
          left: MediaQuery.of(context).size.width / 2 - 30 + dx,
          child: Opacity(
            opacity: _controller.value,
            child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                asset,
                width: 60,
                height: 60,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      'assets/images/scanner.png',
      'assets/images/cv.png',
      // 'assets/images/channel.png',
      'assets/images/ocr.png',
      'assets/images/tools.png',
    ];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (isOpen)
              GestureDetector(
                onTap: toggleMenu,
                child: Container(color: Colors.transparent),
              ),
            for (int i = 0; i < icons.length; i++)
              buildCurvedOption(icons[i], i, icons.length, () {
                switch (icons[i]) {
                  case 'assets/images/tools.png':
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ToolsScreen()));
                    break;
                  case 'assets/images/cv.png':
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CvScreen()));
                    break;
                  case 'assets/images/scanner.png':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DocumentCameraScreen()));
                    break;
                  // case 'assets/images/channel.png':
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) => const ChannelScreen()));
                  //   break;
                  case 'assets/images/ocr.png':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OcrHomeScreen()));
                    break;
                }
              }),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 70,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final iconSize = constraints.maxWidth * 0.08;

                    return Row(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/Left.png',
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: iconSize * 2),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SettingsScreen()),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.settings_outlined,
                                        size: iconSize,
                                        color: selectedIndex == 0
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        AppLocalizations.of(context)!.settings,
                                        style: TextStyle(
                                          fontSize: iconSize * 0.3,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: iconSize * 2.9,
                          height: iconSize * 2.9,
                          child: GestureDetector(
                            onTap: toggleMenu,
                            child: Image.asset(
                              'assets/images/Add icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/Right.png',
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: iconSize * 2),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 1;
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomeScreen()),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home_outlined,
                                        size: iconSize,
                                        color: selectedIndex == 1
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        AppLocalizations.of(context)!.home,
                                        style: TextStyle(
                                          fontSize: iconSize * 0.3,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
