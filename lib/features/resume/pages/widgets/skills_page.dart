import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SkillsPage extends StatefulWidget {
  final ResumeModel resume;
  const SkillsPage({super.key, required this.resume});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  void _addSkill() {
    setState(() {
      widget.resume.skills.add('');
    });
  }

  void _removeSkill(int index) {
    setState(() {
      widget.resume.skills.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final skills = widget.resume.skills;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSkill,
        icon: const Icon(Icons.add),
        label: Text(
          AppLocalizations.of(context)!.addSkill,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(name: AppLocalizations.of(context)!.personalSkills),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 1,
                    child: ListTile(
                      title: TextFormField(
                        initialValue: skills[index],
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? AppColor.primary2
                              : AppColor.primary,
                          // fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.skillName,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) => skills[index] = value,
                      ),
                      trailing: IconButton(
                        onPressed: () => _removeSkill(index),
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
