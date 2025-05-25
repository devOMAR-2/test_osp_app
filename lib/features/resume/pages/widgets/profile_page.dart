import 'package:flutter/material.dart';
import 'package:osp/features/resume/pages/widgets/example.dart';
import 'package:osp/features/resume/pages/widgets/resume_appbar.dart';
import 'package:osp/features/resume/template_model/template_model.dart';
import 'package:osp/features/resume/widgets/profile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  final ResumeModel resume;
  const ProfilePage({super.key, required this.resume});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            AppLocalizations.of(context)!.personalData,
            style: TextStyle(
              // color: Color(0xFF8852A8),
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // _buildHeader(context),
            ResumeAppbar(
              name: AppLocalizations.of(context)!.personalData,
            ),
            TabBar(
              controller: _tabController,
              // labelColor: Color(0xFF8852A8),
              // unselectedLabelColor: Colors.grey,
              // indicatorColor: Color(0xFF8852A8),
              tabs: [
                Tab(
                  text: AppLocalizations.of(context)!.personalData,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.example,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// تبويب المحتوى
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: ProfileWidget(
                      imageFile: widget.resume.profile.profileImage,
                      onChangedProfilePicture: (value) {
                        setState(() {
                          widget.resume.profile.profileImage = value;
                        });
                      },
                      onChangedTitle: (value) =>
                          widget.resume.profile.title = value.trim(),
                      onChangedEmail: (value) =>
                          widget.resume.profile.email = value.trim(),
                      onChangedName: (value) =>
                          widget.resume.profile.name = value.trim(),
                      onChangedPhone: (value) =>
                          widget.resume.profile.phoneNumber = value.trim(),
                      onChangedPortfolio: (value) => widget
                          .resume.profile.yourPortfolioSite = value.trim(),
                      onChangedSummary: (value) =>
                          widget.resume.profile.profileSummary = value.trim(),
                    ),
                  ),

                  /// تبويب الأمثلة
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ExampleSection(names: [
                        "تفاصيل البيانات الشخصية",
                      ]),
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
