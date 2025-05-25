import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/gradient_button.dart';
import 'package:osp/features/resume/pages/resume_preview_page.dart';
import 'package:osp/features/resume/pages/widgets/ability_page.dart';
import 'package:osp/features/resume/pages/widgets/cover_letter.dart';
import 'package:osp/features/resume/pages/widgets/education_page.dart';
import 'package:osp/features/resume/pages/widgets/experience_page.dart';
import 'package:osp/features/resume/pages/widgets/help_page.dart';
import 'package:osp/features/resume/pages/widgets/language_page.dart';
import 'package:osp/features/resume/pages/widgets/more.dart';
import 'package:osp/features/resume/pages/widgets/profile_page.dart';
import 'package:osp/features/resume/pages/widgets/projects_page.dart';
import 'package:osp/features/resume/pages/widgets/skills_page.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResumeFormFlow extends StatefulWidget {
  final int id;
  const ResumeFormFlow({super.key, required this.id});

  @override
  State<ResumeFormFlow> createState() => _ResumeFormFlowState();
}

class _ResumeFormFlowState extends State<ResumeFormFlow> {
  late ResumeModel resume;
  final ValueNotifier<Map<String, bool>> sectionStates = ValueNotifier({
    'اللغات': true,
  });

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    resume = ResumeModel(
      id: widget.id,
      profile: Profile(),
      workExperience: [],
      education: [],
      project: [],
      abilities: [],
      skills: [],
      languages: [],
    );
  }

  bool isSelectionValid() {
    return resume.profile.name.isNotEmpty;
  }

  void _handleNextPressed() {
    setState(() {
      _isValid = isSelectionValid();
    });

    if (_isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumePreview(resume: resume),
        ),
      );
    }
  }

  void navigateToNextSection(Widget page) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
    setState(() {
      _isValid = isSelectionValid(); // تحديث الزر عند الرجوع من القسم
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppLocalizations.of(context)!.personalFile,
              style: TextStyle(
                // color: Color(0xFF8852A8),
                color: AppColor.primary,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: InkWell(
              child: Image.asset(
                'assets/images/back.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.parts,
                    style: TextStyle(
                      // color: Color(0xFF8852A8),
                      color: AppColor.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 16,
                children: [
                  _buildGradientButton(
                      AppLocalizations.of(context)!.personalData,
                      'assets/icons/personal_icon.png',
                      ProfilePage(resume: resume)),
                  _buildGradientButton(
                      AppLocalizations.of(context)!.edu,
                      'assets/icons/tdesign_education.png',
                      EducationPage(resume: resume)),
                  _buildGradientButton(
                      AppLocalizations.of(context)!.experiences,
                      'assets/icons/carbon_ibm-watson-knowledge-studio.png',
                      ExperiencePage(resume: resume)),
                  _buildGradientButton(
                      AppLocalizations.of(context)!.skills,
                      'assets/icons/game-icons_skills.png',
                      SkillsPage(resume: resume)),
                  _buildGradientButton(AppLocalizations.of(context)!.abilities,
                      'assets/icons/Vector.png', AbilitiesPage(resume: resume)),
                  ValueListenableBuilder<Map<String, bool>>(
                    valueListenable: sectionStates,
                    builder: (context, value, child) {
                      if (value[AppLocalizations.of(context)!.languages] ==
                          false) {
                        return const SizedBox.shrink();
                      }
                      return _buildGradientButton(
                          AppLocalizations.of(context)!.languages,
                          'assets/icons/reviewer.png',
                          LanguagesPage(resume: resume));
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.moreParts,
                    style: TextStyle(
                      // color: Color(0xFF8852A8),
                      color: AppColor.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 16,
                children: [
                  ValueListenableBuilder<Map<String, bool>>(
                    valueListenable: sectionStates,
                    builder: (context, value, child) {
                      if (value[AppLocalizations.of(context)!.projects] ==
                          false) {
                        return const SizedBox.shrink();
                      }
                      return _buildGradientButton(
                          AppLocalizations.of(context)!.projects,
                          'assets/icons/eos-icons_project-outlined.png',
                          ProjectsPage(resume: resume));
                    },
                  ),
                  // _buildGradientButton(
                  //     AppLocalizations.of(context)!.projects,
                  //     'assets/icons/eos-icons_project-outlined.png',
                  //     ProjectsPage(resume: resume)),
                  _buildGradientButton(
                      AppLocalizations.of(context)!.coverLetter,
                      'assets/icons/solar_letter-bold.png',
                      CoverLetterPage(resume: resume)),
                  _buildGradientButton(
                      AppLocalizations.of(context)!.addMore,
                      'assets/icons/cbi_more-tv.png',
                      MorePage(sectionStates: sectionStates)),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.partManagement,
                    style: TextStyle(
                      // color: Color(0xFF8852A8),
                      color: AppColor.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 16,
                    children: [
                      _buildGradientButton(
                          AppLocalizations.of(context)!.help,
                          'assets/icons/material-symbols_help-outline.png',
                          HelpPage()),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomButton(
                width: 200,
                height: 50,
                text: AppLocalizations.of(context)!.clickCv,
                onPressed: _handleNextPressed,
                color: _isValid ? Colors.grey.shade300 : AppColor.primary,
                textColor: _isValid ? Colors.grey : AppColor.primary,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, String image, Widget page) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 16,
      child: GradientButton(
        text: text,
        image: image,
        onPressed: () => navigateToNextSection(page),
      ),
    );
  }
}
