import 'package:flutter/material.dart';

class LanguageRecognitionScreen extends StatefulWidget {
  const LanguageRecognitionScreen({super.key,});

  @override
  _LanguageRecognitionScreenState createState() =>
      _LanguageRecognitionScreenState();
}

class _LanguageRecognitionScreenState extends State<LanguageRecognitionScreen> {
  // لتخزين حالة التحميل لكل لغة
  Map<String, bool> isLoading = {};
  Map<String, bool> isDownloaded = {};

  // قائمة اللغات
  final List<String> languages = [
    'العربية',
    'البلغارية',
    'الكاتالونية',
    'الألمانية',
    'اليونانية',
    'الإنجليزية',
    'الإسبانية',
    'الفرنسية',
    'الهندية',
    'الإندنوسية',
    'الإيطالية',
    'اليابانية',
    'الكورية',
    'الماليزية',
    'الهولندية',
    'البولندية',
    'البرتغالية',
    'الروسية',
    'السويدية',
    'التايلاندية',
    'التركية',
    'الأوكرانية',
    'الفيتنامية',
    'الصينية - البسيطة',
    'الصينية - التقليدية',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView( // يسمح بالتمرير للأسفل
            child: Container(
              constraints: const BoxConstraints(maxWidth: 360),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Header
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8E9BAE).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBackButton(context),
                        Text(
                          'لغة التعرف على النصوص',
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xFF8852A8).withOpacity(0.8),
                          ),
                        ),
                        _buildMenuButton(),
                      ],
                    ),
                  ),
                  // Language List
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Download Icons Column
                        SizedBox(
                          width: 29,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: _buildDownloadIconsColumn(),
                          ),
                        ),
                        // Language Names Column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _buildLanguageNamesColumn(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF8852A8).withOpacity(0.4),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: const Color(0xFF8852A8).withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return SizedBox(
      width: 40,
      height: 60,
      child: Icon(
        Icons.more_vert,
        color: const Color(0xFF8852A8).withOpacity(0.8),
      ),
    );
  }

  Widget _buildDownloadIconsColumn() {
    return Column(
      children: List.generate(
        languages.length, // استخدام length الديناميكي للقائمة
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: _buildDownloadIcon(index),
        ),
      ),
    );
  }

  // تغيير زر التحميل ليكون متفاعلًا ويتحول إلى Checkbox
  Widget _buildDownloadIcon(int index) {
    String language = languages[index];

    return GestureDetector(
      onTap: () {
        // عند الضغط على الزر، نغير حالة التحميل الخاصة باللغة
        setState(() {
          isLoading[language] = true;  // بدء عملية التحميل
        });

        // محاكاة عملية تحميل عبر الانتظار لمدة معينة ثم العودة للحالة الأصلية
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isLoading[language] = false;  // إيقاف التحميل
            isDownloaded[language] = true; // تحديث حالة التنزيل بعد التحميل
          });
        });
      },
      child: Container(
        width: 16,
        height: 20,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFEEDBED).withOpacity(0.8),
              const Color(0xFF8852A8).withOpacity(0.8),
            ],
          ),
        ),
        child: isLoading[language] == true
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : isDownloaded[language] == true
                ? const Icon(
                    Icons.check_box,
                    size: 16,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.download,
                    size: 16,
                    color: Colors.white,
                  ),
      ),
    );
  }

  Widget _buildLanguageNamesColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: languages.map((language) => _buildLanguageItem(language, context)).toList(),
    );
  }

  Widget _buildLanguageItem(String language, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم اختيار اللغة: $language')),
          );
        },
        child: Text(
          language,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            height: 1.25,
            color: const Color(0xFF8852A8).withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
