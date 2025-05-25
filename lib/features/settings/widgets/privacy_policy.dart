import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  TextDirection _dir(BuildContext ctx) =>
      Localizations.localeOf(ctx).languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dir = _dir(context);

    return Directionality(
      textDirection: dir,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, dir),
                _buildSection(title: t.privacy_body1, content: t.privacy_body1),
                _buildSection(
                    title: t.privacy_header2, content: t.privacy_body2),
                _buildSection(
                    title: t.privacy_header3, content: t.privacy_body3),
                _buildSection(
                    title: t.privacy_header4, content: t.privacy_body4),
                _buildSection(
                    title: t.privacy_header5, content: t.privacy_body5),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: Text(t.back),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8852A8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextDirection dir) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset('assets/images/Osp logo.png',
                width: 70, height: 40, fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              child: Image.asset('assets/images/back.png',
                  width: 80, height: 80, fit: BoxFit.contain),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5E2D91))),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.6)),
        ],
      ),
    );
  }
}
