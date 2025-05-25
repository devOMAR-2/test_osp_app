import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:osp/features/resume/widgets/primary_textfield.dart';
import 'package:osp/features/resume/pages/widgets/example.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExperiencePage extends StatefulWidget {
  final ResumeModel resume;
  const ExperiencePage({super.key, required this.resume});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _addExperience() {
    setState(() {
      widget.resume.workExperience.add(WorkExperience(
        companyName: '',
        jobResponsibilities: [],
        isCurrentlyWorking: false,
        startDate: '',
        endDate: '',
        designation: '',
      ));
    });
  }

  void _removeExperience(int index) {
    setState(() {
      widget.resume.workExperience.removeAt(index);
    });
  }

  void _addResponsibility(int expIndex) {
    setState(() {
      widget.resume.workExperience[expIndex].jobResponsibilities.add('');
    });
  }

  void _removeResponsibility(int expIndex, int resIndex) {
    setState(() {
      widget.resume.workExperience[expIndex].jobResponsibilities
          .removeAt(resIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final experiences = widget.resume.workExperience;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton.extended(
              onPressed: _addExperience,
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.addexperience),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(
              name: AppLocalizations.of(context)!.experiences,
            ),
            TabBar(
              controller: _tabController,
              // labelColor: Color(0xFF8852A8),
              // unselectedLabelColor: Colors.grey,
              // indicatorColor: Color(0xFF8852A8),
              tabs: [
                Tab(text: AppLocalizations.of(context)!.experiences),
                Tab(text: AppLocalizations.of(context)!.example),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// المحتوى
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ...experiences.asMap().entries.map((entry) {
                        final index = entry.key;
                        final experience = entry.value;

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextfield(
                                  hintText: AppLocalizations.of(context)!
                                      .enterCompany,
                                  label:
                                      AppLocalizations.of(context)!.compantName,
                                  onChanged: (value) =>
                                      experience.companyName = value,
                                ),
                                PrimaryTextfield(
                                  hintText: AppLocalizations.of(context)!
                                      .enterjobNaming,
                                  label:
                                      AppLocalizations.of(context)!.jobNaming,
                                  onChanged: (value) =>
                                      experience.designation = value,
                                ),
                                ListTile(
                                  title: Text(
                                    "${AppLocalizations.of(context)!.startDate}: ${experience.startDate.isNotEmpty ? experience.startDate : AppLocalizations.of(context)!.notSpecify}",
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
                                        experience.startDate =
                                            dateFormat.format(picked);
                                      });
                                    }
                                  },
                                ),
                                if (!experience.isCurrentlyWorking)
                                  ListTile(
                                    title: Text(
                                      "${AppLocalizations.of(context)!.endDate}: ${experience.endDate.isNotEmpty ? experience.endDate : AppLocalizations.of(context)!.notSpecify}",
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
                                          experience.endDate =
                                              dateFormat.format(picked);
                                        });
                                      }
                                    },
                                  ),
                                CheckboxListTile(
                                  value: experience.isCurrentlyWorking,
                                  onChanged: (value) {
                                    setState(() {
                                      experience.isCurrentlyWorking =
                                          value ?? false;
                                      if (experience.isCurrentlyWorking) {
                                        experience.endDate = '';
                                      }
                                    });
                                  },
                                  title: Text(AppLocalizations.of(context)!
                                      .stillworking),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  // alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!.responsiblity,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      experience.jobResponsibilities.length,
                                  itemBuilder: (context, resIndex) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryTextfield(
                                            hintText:
                                                "${AppLocalizations.of(context)!.repoiblity} ${resIndex + 1}",
                                            controller: TextEditingController(
                                              text: experience
                                                      .jobResponsibilities[
                                                  resIndex],
                                            ),
                                            onChanged: (value) =>
                                                experience.jobResponsibilities[
                                                    resIndex] = value,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              _removeResponsibility(
                                                  index, resIndex),
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                TextButton.icon(
                                  onPressed: () => _addResponsibility(index),
                                  icon: Icon(Icons.add,
                                      color: themeProvider.isDarkMode
                                          ? Color(0xFFEEDBED)
                                          : AppColor.primary),
                                  label: Text(
                                      AppLocalizations.of(context)!
                                          .addresponsiblity,
                                      style: TextStyle(
                                          color: themeProvider.isDarkMode
                                              ? Color(0xFFEEDBED)
                                              : AppColor.primary)),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton.icon(
                                    onPressed: () => _removeExperience(index),
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
                      const SizedBox(height: 100),
                    ],
                  ),

                  /// الأمثلة
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ExampleSection(names: ["الخبرات العملية الشخصية"]),
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
