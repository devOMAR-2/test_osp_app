import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../auth/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TechnicalSupportPage extends StatelessWidget {
  const TechnicalSupportPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: 3.1416,
                  child: Image.asset(
                    'assets/images/BG.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // المحتوى الأساسي
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const SizedBox(height: 100),
                    Text(
                      AppLocalizations.of(context)!.technicalSupport,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0x888852A8),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildField(AppLocalizations.of(context)!.fullname,
                                context),
                            _buildField(
                                AppLocalizations.of(context)!.email, context),
                            _buildDropdown(context),
                            _buildField(
                                AppLocalizations.of(context)!
                                    .problemDescription,
                                context,
                                maxLines: 5),
                            const SizedBox(height: 24),
                            CustomButton(
                              width: isSmallScreen ? 160 : 180,
                              height: 50,
                              text: AppLocalizations.of(context)!.send,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!
                                        .sentTitle),
                                    content: Text(AppLocalizations.of(context)!
                                        .sentMessage),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: Text(
                                            AppLocalizations.of(context)!.ok),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/back.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, BuildContext context, {int maxLines = 1}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color:
              const Color(0xFFF6F2F6).withOpacity(0.6), // خلفية ناعمة بنفسجية
          borderRadius: BorderRadius.circular(30), // حواف ناعمة مثل الصورة
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          maxLines: maxLines,
          style: TextStyle(
            color:
                themeProvider.isDarkMode ? AppColor.primary2 : AppColor.primary,
          ), // لون النص بالشفافية 80%
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
                color: Color(0x888852A8)), // لون النص بالشفافية 80%
            filled: true,
            fillColor: const Color(0x4DEEDBED).withOpacity(0.3),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0x4DEEDBED),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.problemType,
            labelStyle: const TextStyle(color: Color(0x888852A8)),
            filled: true,
            fillColor: const Color(0x4DEEDBED).withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          items: [
            DropdownMenuItem(
                value: AppLocalizations.of(context)!.problemSignup,
                child: Text(
                  AppLocalizations.of(context)!.problemSignup,
                )),
            DropdownMenuItem(
                value: AppLocalizations.of(context)!.problemDownload,
                child: Text(
                  AppLocalizations.of(context)!.problemDownload,
                )),
            DropdownMenuItem(
                value: AppLocalizations.of(context)!.suggestion,
                child: Text(
                  AppLocalizations.of(context)!.suggestion,
                )),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
