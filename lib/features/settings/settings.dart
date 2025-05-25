import 'package:flutter/material.dart';
import 'package:osp/core/routing/routes_name.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/auth/data/models/user_model.dart';
import 'package:osp/features/profile/profile_dialog.dart';
import 'package:osp/features/settings/widgets/languages.dart';
import 'package:osp/features/settings/widgets/privacy_policy.dart';
import 'package:osp/features/settings/widgets/terms.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../profile_avatar.dart';
import 'technicalsupportpage.dart';
import '../languages.dart';
import '../bottom_nav_bar/custom_buttom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osp/core/theme/app_color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _askBeforeUsingData = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    final client = Supabase.instance.client;
    final session = client.auth.currentSession;

    if (session == null) {
      if (mounted) {
        setState(() {
          _user = null;
        });
      }
      return;
    }

    try {
      final response = await client.auth.getUser();
      if (mounted) {
        setState(() {
          _user = response.user;
        });
      }
    } catch (e, stackTrace) {
      print('❌ Error fetching user profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل الملف الشخصي')),
      );

      print(stackTrace);

      if (mounted) {
        setState(() {
          _user = null;
        });
      }
    }
  }

  void onRightSidePressed() {
    print('Right side pressed');
  }

  @override
  Widget build(BuildContext context) {
    final SupabaseClient client = Supabase.instance.client;
    final session = client.auth.currentSession;

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            // Header Section
            SizedBox(
              height: 81,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/Osp logo.png',
                        width: 100,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Profile Section

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEDBED).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ProfileAvatar(),
                      SizedBox(height: 10),
                      Text(
                        (session == null || _user?.email == null)
                            ? AppLocalizations.of(context)!.signUP
                            : _user!.email!,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  if (session == null || _user?.email == null) {
                    Navigator.pushNamed(context, RoutesName.signup);
                  } else {
                    // is log in
                    final response = await client.auth.getUser();
                    final user = response.user;
                    print('✅ Logged in as: ${user!.email}');

                    final profileResponse = await client
                        .from('profiles')
                        .select()
                        .eq('id', user.id)
                        .single();

                    print('👤 User Profile: $profileResponse');

                    final userModel = UserModel.fromMap(profileResponse);
                    print('🧾 Username: ${userModel.username}');

                    showDialog(
                      context: context,
                      builder: (_) => ProfileScreen(
                        user: userModel,
                        email: user.email.toString(),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            // حساب Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.account,
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDarkMode
                          ? AppColor.primary2
                          : AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildAccountItem(
                    AppLocalizations.of(context)!.currentmembership,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/Premium ad.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 32),
                  _buildAccountItem(
                    AppLocalizations.of(context)!.restorePurchases,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // التفضيلات Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.favorites,
                    style: TextStyle(
                      fontSize: 15,
                      color: themeProvider.isDarkMode
                          ? AppColor.primary2
                          : AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPreferenceItem(
                      AppLocalizations.of(context)!.askBeforeuseMobile,
                      _askBeforeUsingData, (value) {
                    setState(() {
                      _askBeforeUsingData = value;
                    });
                  }),
                  const SizedBox(height: 32),
                  // _buildPreferenceItem(
                  //     AppLocalizations.of(context)!.darkmode, _isDarkMode,
                  //     (value) {
                  //   setState(() {
                  //     _isDarkMode = value;
                  //   });
                  // }),
                  _buildPreferenceItem(
                    AppLocalizations.of(context)!.darkmode,
                    context.watch<ThemeProvider>().isDarkMode,
                    (value) {
                      context.read<ThemeProvider>().toggleTheme(value);
                    },
                  ),

                  const SizedBox(height: 32),
                  _buildTextRecognitionItem(),
                  const SizedBox(height: 32),
                  _buildAppLanguageItem(),
                ],
              ),
            ),
            const Divider(height: 1),
            // المزيد Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.moreoptions,
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDarkMode
                          ? AppColor.primary2
                          : AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildMoreItem(
                      AppLocalizations.of(context)!.termsandConditions, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TermsAndPoliciesScreen()));
                  }),
                  const SizedBox(height: 32),
                  _buildMoreItem(AppLocalizations.of(context)!.privacypolicy,
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PrivacyPolicyScreen()));
                  }),
                  const SizedBox(height: 32),
                  _buildMoreItem(AppLocalizations.of(context)!.whoAre, () {}),
                  const SizedBox(height: 32),
                  _buildMoreItem(AppLocalizations.of(context)!.appshare, () {
                    //share the app
                    final String appLink = 'https://example.com/app-download';
                    Share.share(appLink);
                  }),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TechnicalSupportPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.help,
                          style: TextStyle(
                            fontSize: 18,
                            color: themeProvider.isDarkMode
                                ? AppColor.primary2
                                : AppColor.primary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // شعار OSP Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Image.asset(
                  'assets/images/Osp logo.png',
                  width: 150,
                  height: 75,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPreferenceItem(
      String title, bool value, Function(bool) onChanged) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color:
                themeProvider.isDarkMode ? AppColor.primary2 : AppColor.primary,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          // activeColor: const Color(0xCC4B0082),
        ),
      ],
    );
  }

  Widget _buildTextRecognitionItem() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LanguageRecognitionScreen()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.langauageDetection,
            style: TextStyle(
              fontSize: 18,
              color: themeProvider.isDarkMode
                  ? AppColor.primary2
                  : AppColor.primary,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildAppLanguageItem() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppLanguageScreen()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.appLanguage,
            style: TextStyle(
              fontSize: 18,
              color: themeProvider.isDarkMode
                  ? AppColor.primary2
                  : AppColor.primary,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(String title) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color:
                themeProvider.isDarkMode ? AppColor.primary2 : AppColor.primary,
          ),
        ),
        if (title == AppLocalizations.of(context)!.currentmembership)
          Text(
            AppLocalizations.of(context)!.free,
            style: TextStyle(
              fontSize: 16,
              color: themeProvider.isDarkMode
                  ? AppColor.primary2
                  : AppColor.primary,
            ),
          ),
      ],
    );
  }

  Widget _buildMoreItem(String title, GestureTapCallback onTap) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: themeProvider.isDarkMode
                  ? AppColor.primary2
                  : AppColor.primary,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ],
      ),
    );
  }
}
