import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndPoliciesScreen extends StatelessWidget {
  const TermsAndPoliciesScreen({super.key});

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
          // backgroundColor: const Color(0xFFF8F5FC),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, dir),
                _buildSection(title: t.terms_header1, content: t.terms_body1),
                _buildSection(title: t.terms_header2, content: t.terms_body2),
                _buildSection(title: t.terms_header3, content: t.terms_body3),
                _buildSection(title: t.terms_header4, content: t.terms_body4),
                _buildSection(title: t.terms_header5, content: t.terms_body5),
                _buildSection(title: t.terms_header6, content: t.terms_body6),
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
