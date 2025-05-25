import 'package:flutter/material.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:osp/features/resume/widgets/description_textField.dart';
import 'package:osp/features/resume/widgets/primary_textfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectsPage extends StatefulWidget {
  final ResumeModel resume;
  const ProjectsPage({super.key, required this.resume});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  void _addProject() {
    setState(() {
      widget.resume.project.add(Projects());
    });
  }

  void _removeProject(int index) {
    setState(() {
      widget.resume.project.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectsList = widget.resume.project;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProject,
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.personalprojects),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(name: AppLocalizations.of(context)!.personalprojects),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: projectsList.length,
                itemBuilder: (context, index) {
                  final project = projectsList[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          PrimaryTextfield(
                            hintText: AppLocalizations.of(context)!.projectName,
                            label: AppLocalizations.of(context)!.projectName,
                            onChanged: (value) => project.projectName = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DescriptionTextfield(
                            hintText: AppLocalizations.of(context)!
                                .projectDescription,
                            label: AppLocalizations.of(context)!
                                .projectDescription,
                            onChanged: (value) => project.description = value,
                          ),

                          // تاريخ البداية
                          ListTile(
                            title: Text(
                              "${AppLocalizations.of(context)!.startDate}: ${project.startDate.isNotEmpty ? project.startDate : AppLocalizations.of(context)!.notSpecify}",
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
                                  project.startDate = dateFormat.format(picked);
                                });
                              }
                            },
                          ),

                          // تاريخ الانتهاء
                          ListTile(
                            title: Text(
                              "${AppLocalizations.of(context)!.projectEndDate}: ${project.endDate.isNotEmpty ? project.endDate : AppLocalizations.of(context)!.notSpecify}",
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
                                  project.endDate = dateFormat.format(picked);
                                });
                              }
                            },
                          ),

                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _removeProject(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
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
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
