import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CoverLetterPage extends StatefulWidget {
  final ResumeModel resume;
  const CoverLetterPage({super.key, required this.resume});

  @override
  State<CoverLetterPage> createState() => _CoverLetterPageState();
}

class _CoverLetterPageState extends State<CoverLetterPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.resume.coverLetter ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveCoverLetter() {
    widget.resume.coverLetter = _controller.text;
    // ممكن تحفظ البيانات هنا في قاعدة أو ملف مؤقت
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) return;
        _saveCoverLetter();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ResumeAppbar(
                name: AppLocalizations.of(context)!.coverLetter,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? AppColor.primary2
                          : AppColor.primary,
                      // fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: themeProvider.isDarkMode
                              ? AppColor.primary2
                              : AppColor.primary),
                      labelText: AppLocalizations.of(context)!.writeCoverLetter,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
