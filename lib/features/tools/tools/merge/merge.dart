import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import '../../../auth/widgets/custom_button.dart'; // استيراد CustomButton
import '../../widgets/customappbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MergePdf extends StatelessWidget {
  const MergePdf({super.key, required this.selectedFiles});

  // استلام قائمة الملفات المحددة من الصفحة السابقة
  final List<String> selectedFiles;
  @override
  Widget build(BuildContext context) {
    print("الملفات المستلمة للدمج: $selectedFiles");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
            onBackPressed: () {}, title: AppLocalizations.of(context)!.merge),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.drag_handle,
                          size: 24,
                          color: const Color(0xFF8852A8)
                              .withOpacity(0.8), // نفس اللون مع 80% شفافية
                        ),
                        Text(
                          AppLocalizations.of(context)!.pullfiles,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF8852A8).withOpacity(
                                0.8), // نفس لون العنوان في شريط التنقل
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // إذا كانت القائمة خالية من الملفات
                    selectedFiles.isEmpty
                        ? Column(
                            children: [
                              Image.asset(
                                'assets/images/No_files_Found.png',
                                width: 119,
                                height: 119 /
                                    1.07, // الحفاظ على نسبة العرض إلى الارتفاع
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'لا يوجد ملفات !',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B46C1),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: selectedFiles.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  title: Text(
                                    selectedFiles[index].toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF6B46C1),
                                    ),
                                  ),
                                  leading: const Icon(
                                    Icons.picture_as_pdf,
                                    color: Color(0xFF6B46C1),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              // زر دمج الملفات أسفل الصفحة
              Positioned(
                bottom: 30, // تحديد الزر ليكون في الأسفل
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 180,
                    height: 50,
                    text: AppLocalizations.of(context)!.merge,
                    onPressed: () {
                      // عمل دمج الملفات هنا
                      CloudmersiveConverter.mergeSelectedPdfs(
                          context, selectedFiles);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
