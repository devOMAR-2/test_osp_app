import 'package:flutter/material.dart';

class CustomToolsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final double logoSize;
  final List<String> icons;
  final double iconSize;
  final List<VoidCallback> onIconTap;

  const CustomToolsAppBar({
    super.key,
    required this.logoPath,
    required this.logoSize,
    required this.icons,
    required this.iconSize,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true, // Let Scaffold handle the back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              icons.length,
              (index) => GestureDetector(
                onTap: onIconTap[index],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    icons[index],
                    width: iconSize,
                    height: iconSize,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: logoSize,
            height: logoSize,
            child: Image.asset(logoPath),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
