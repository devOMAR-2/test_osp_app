import 'package:flutter/material.dart';
import 'package:osp/core/languagechanger/controller/language_change_controller.dart';
import 'package:osp/core/networking/di/dependency_injection.dart';
import 'package:osp/core/routing/routes.dart';
import 'package:osp/core/routing/routes_name.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String? languageCode = sp.getString('language_code');
  final initialLocale =
      languageCode != null ? Locale(languageCode) : const Locale('en');
  await Supabase.initialize(
    url: 'https://zgjmyggurkdzlviuswow.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpnam15Z2d1cmtkemx2aXVzd293Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU1MTQ4MzQsImV4cCI6MjA2MTA5MDgzNH0.JbY7U7h7_9FRV382HxbB2FL7mhJGEhqmij9fOdWG4Sk',
  );
  await setupGetIt(); // Initialize DI
  runApp(MyApp(initialLocale: initialLocale));
}

enum Language { english, arabic }

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              LanguageChangeController()..setInitialLocale(initialLocale),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer2<LanguageChangeController, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
          return MaterialApp(
            builder: (context, widget) {
              final mediaQueryData = MediaQuery.of(context);
              final scaledMediaQueryData = mediaQueryData.copyWith(
                textScaler: TextScaler.noScaling,
              );
              return MediaQuery(
                data: scaledMediaQueryData,
                child: widget!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'OSP',
            theme: AppColor.customLightTheme,
            darkTheme: AppColor.customDarkTheme,
            themeMode: themeProvider.currentTheme,
            locale: languageProvider.appLocale ?? const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Arabic
            ],
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showOspLogo = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            showOspLogo = true;
          });

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.home, (route) => false);
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!showOspLogo)
              ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: 150,
                ),
              ),
            AnimatedOpacity(
              opacity: showOspLogo ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Image.asset(
                'assets/images/Osp logo.png',
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
