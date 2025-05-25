import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AbilitiesPage extends StatefulWidget {
  final ResumeModel resume;
  const AbilitiesPage({super.key, required this.resume});

  @override
  State<AbilitiesPage> createState() => _AbilitiesPageState();
}

class _AbilitiesPageState extends State<AbilitiesPage> {
  void _addAbility() {
    setState(() {
      widget.resume.abilities.add('');
    });
  }

  void _removeAbility(int index) {
    setState(() {
      widget.resume.abilities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final abilities = widget.resume.abilities;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addAbility,
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addAbility),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ResumeAppbar(name: AppLocalizations.of(context)!.personalAbility),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: abilities.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 1,
                    child: ListTile(
                      title: TextFormField(
                        initialValue: abilities[index],
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
                          labelText:
                              AppLocalizations.of(context)!.whatisyourAbility,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => abilities[index] = value,
                      ),
                      trailing: IconButton(
                        onPressed: () => _removeAbility(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
