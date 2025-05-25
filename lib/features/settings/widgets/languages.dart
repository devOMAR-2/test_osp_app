import 'package:flutter/material.dart';
import 'package:osp/core/languagechanger/controller/language_change_controller.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class AppLanguageScreen extends StatelessWidget {
  const AppLanguageScreen({super.key});

  void _changeLanguageWithFeedback(
    BuildContext context,
    Locale locale,
    String message,
  ) {
    final provider =
        Provider.of<LanguageChangeController>(context, listen: false);
    provider.changeLanguage(locale);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Image.asset(
            'assets/images/Osp logo.png',
            width: 70,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Center(
                child: Consumer<LanguageChangeController>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildLanguageButton(
                            context,
                            title: "English",
                            localeCode: 'en',
                            isSelected: provider.appLocale == 'en',
                            onTap: () => _changeLanguageWithFeedback(
                              context,
                              const Locale('en'),
                              'Language changed to English ✅',
                            ),
                          ),
                          const SizedBox(height: 12),
                          buildLanguageButton(
                            context,
                            title: "العربية",
                            localeCode: 'ar',
                            isSelected: provider.appLocale == 'ar',
                            onTap: () => _changeLanguageWithFeedback(
                              context,
                              const Locale('ar'),
                              'تم تغيير اللغة إلى العربية ✅',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLanguageButton(
    BuildContext context, {
    required String title,
    required String localeCode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.language,
              // color: isSelected ? Colors.white : Colors.black,
              color: themeProvider.isDarkMode
                  ? AppColor.primary2
                  : AppColor.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  // color: isSelected ? Colors.white : Colors.black,
                  color: themeProvider.isDarkMode
                      ? AppColor.primary2
                      : AppColor.primary,
                  fontSize: 16,
                  fontFamily: "cairo",
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
