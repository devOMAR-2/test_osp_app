import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/features/resume/pages/widgets/example.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:osp/features/resume/widgets/primary_textfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EducationPage extends StatefulWidget {
  final ResumeModel resume;
  const EducationPage({super.key, required this.resume});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage>
    with SingleTickerProviderStateMixin {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // يعيد بناء الواجهة عند تغيير التبويب
    });
  }

  void _addEducation() {
    setState(() {
      widget.resume.education.add(Education());
    });
  }

  void _removeEducation(int index) {
    setState(() {
      widget.resume.education.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final educationList = widget.resume.education;

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          if (_tabController.index == 1)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, bottom: 16),
                child: FloatingActionButton.extended(
                  onPressed: _addEducation,
                  icon: const Icon(Icons.add),
                  label: Text(
                    AppLocalizations.of(context)!.eduQuali,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(
              name: AppLocalizations.of(context)!.eduQuali,
            ),
            TabBar(
              controller: _tabController,
              // labelColor: AppColor.primary,
              // unselectedLabelColor: Colors.grey,
              // indicatorColor: AppColor.primary,
              tabs: [
                Tab(
                  text: AppLocalizations.of(context)!.example,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.edu,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// تبويب الأمثلة
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ExampleSection(names: [
                        "بكالوريوس إدارة أعمال",
                        "تقنية معلومات",
                        "التعليم",
                      ]),
                    ],
                  ),

                  /// المحتوى
                  ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      ...educationList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final education = entry.value;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              spacing: 10,
                              children: [
                                PrimaryTextfield(
                                  hintText: AppLocalizations.of(context)!
                                      .universityName,
                                  label: AppLocalizations.of(context)!
                                      .universityName,
                                  onChanged: (value) =>
                                      education.university = value,
                                ),
                                PrimaryTextfield(
                                  hintText: AppLocalizations.of(context)!
                                      .specialization,
                                  label: AppLocalizations.of(context)!
                                      .specialization,
                                  onChanged: (value) =>
                                      education.studyCourse = value,
                                ),
                                ListTile(
                                  title: Text(
                                    " ${AppLocalizations.of(context)!.startDate}: ${education.startDate.isNotEmpty ? education.startDate : AppLocalizations.of(context)!.notSpecify}",
                                  ),
                                  trailing: const Icon(Icons.calendar_today),
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1980),
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        education.startDate =
                                            dateFormat.format(picked);
                                      });
                                    }
                                  },
                                ),
                                if (!education.isCurrentlyStudying)
                                  ListTile(
                                    title: Text(
                                      " ${AppLocalizations.of(context)!.endDate}: ${education.endDate.isNotEmpty ? education.endDate : AppLocalizations.of(context)!.notSpecify}",
                                    ),
                                    trailing: const Icon(Icons.calendar_today),
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1980),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          education.endDate =
                                              dateFormat.format(picked);
                                        });
                                      }
                                    },
                                  ),
                                CheckboxListTile(
                                  value: education.isCurrentlyStudying,
                                  onChanged: (value) {
                                    setState(() {
                                      education.isCurrentlyStudying =
                                          value ?? false;
                                      if (education.isCurrentlyStudying) {
                                        education.endDate = '';
                                      }
                                    });
                                  },
                                  title: Text(AppLocalizations.of(context)!
                                      .stillStuding),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton.icon(
                                    onPressed: () => _removeEducation(index),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    label: Text(
                                      AppLocalizations.of(context)!.delete,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 150),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
