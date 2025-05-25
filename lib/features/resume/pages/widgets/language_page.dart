import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguagesPage extends StatefulWidget {
  final ResumeModel resume;
  const LanguagesPage({super.key, required this.resume});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  void _addLanguage() {
    setState(() {
      widget.resume.languages.add('');
    });
  }

  void _removeLanguage(int index) {
    setState(() {
      widget.resume.languages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final languages = widget.resume.languages;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addLanguage,
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addLanguage),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(name: AppLocalizations.of(context)!.languagespart),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 1,
                    child: ListTile(
                      title: TextFormField(
                        initialValue: languages[index],
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? AppColor.primary2
                              : AppColor.primary,
                          // fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          labelText: AppLocalizations.of(context)!.addLanguage,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => languages[index] = value,
                      ),
                      trailing: IconButton(
                        onPressed: () => _removeLanguage(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
