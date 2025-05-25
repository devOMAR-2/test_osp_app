import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/tools/tools_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MorePage extends StatefulWidget {
  final ValueNotifier<Map<String, bool>> sectionStates;

  const MorePage({super.key, required this.sectionStates});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // العناوين (لاحظ استخدام الترجمة)
    final sectionTitles = [
      l10n.additionalInfo,
      l10n.references,
      l10n.interests,
      l10n.projects,
      l10n.languages,
      l10n.achievementsAwards,
      l10n.hobbies,
      l10n.signature,
      l10n.publications,
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(name: l10n.addMore),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sectionTitles.length,
                  itemBuilder: (context, index) {
                    String title = sectionTitles[index];

                    // إذا لم تُحفظ قيمة بعد، نفعِّل المشاريع واللغات فقط
                    bool isEnabled = widget.sectionStates.value[title] ??
                        (title == l10n.projects || title == l10n.languages);

                    return Card(
                      color: const Color.fromARGB(230, 255, 255, 255),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 1,
                      child: ListTile(
                        title: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.primary,
                          ),
                        ),
                        trailing: Switch(
                          value: isEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              widget.sectionStates.value[title] = value;
                              widget.sectionStates.notifyListeners();
                            });
                          },
                          activeColor: AppColor.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
