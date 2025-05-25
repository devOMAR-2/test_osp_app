import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const List<Map<String, String>> _sectionsAr = [
    {
      "title": "مقدمة",
      "description":
          "مرحبًا بك في صفحة المساعدة! هنا ستتعرف على كل قسم من أقسام السيرة الذاتية، وكيفية تعبئته بشكل احترافي."
    },
    {
      "title": "البيانات الشخصية",
      "description":
          "قم بإضافة اسمك، وظيفتك الحالية أو المرغوبة، رقم الهاتف، البريد الإلكتروني، ورابط محفظة أعمالك إن وجد. لا تنسَ كتابة ملخص شخصي مختصر عنك."
    },
    {
      "title": "التعليم",
      "description":
          "أضف الجامعات أو المعاهد التي التحقت بها، تواريخ البدء والانتهاء، والتخصص الدراسي. يمكنك تحديد أنك لا تزال تدرس."
    },
    {
      "title": "الخبرات العملية",
      "description":
          "أضف الوظائف السابقة أو الحالية التي عملت بها، مع تحديد المسمى الوظيفي، اسم الشركة، المدة الزمنية، والمسؤوليات الرئيسية."
    },
    {
      "title": "المهارات",
      "description":
          "أضف المهارات التقنية أو الشخصية التي تتمتع بها، مثل: العمل الجماعي، القيادة، Flutter، التصميم... إلخ."
    },
    {
      "title": "القدرات",
      "description":
          "هي صفات شخصية أو قدرات احترافية تميزك، مثل: العمل تحت الضغط، سرعة التعلم، التفكير التحليلي... إلخ."
    },
    {
      "title": "اللغات",
      "description":
          "حدد اللغات التي تتقنها، يمكنك إضافة أكثر من لغة بحسب مستواك فيها."
    },
    {
      "title": "المشاريع",
      "description":
          "يمكنك إضافة مشاريع عملت عليها (سواء أكاديمية أو شخصية أو احترافية)، مع توضيح المسمى والوصف والفترة الزمنية."
    },
    {
      "title": "الخطاب التعريفي (Cover Letter)",
      "description":
          "هو نص مختصر توجهه لصاحب العمل لتشرح فيه من أنت، ولماذا أنت مناسب لهذه الوظيفة. يُرفق عادة بجانب السيرة الذاتية."
    },
  ];

  static const List<Map<String, String>> _sectionsEn = [
    {
      "title": "Introduction",
      "description":
          "Welcome to the help page! Here, you'll learn about each section of the résumé and how to fill it out professionally."
    },
    {
      "title": "Personal Information",
      "description":
          "Add your name, current or desired job title, phone number, email, and a portfolio link if available. Don’t forget to include a short personal summary."
    },
    {
      "title": "Education",
      "description":
          "Include universities or institutions you attended, the dates, and your major. You can indicate if you're still studying."
    },
    {
      "title": "Work Experience",
      "description":
          "List previous or current jobs including job title, company name, duration, and main responsibilities."
    },
    {
      "title": "Skills",
      "description":
          "Add technical or soft skills you possess, such as teamwork, leadership, Flutter, design, etc."
    },
    {
      "title": "Abilities",
      "description":
          "Professional or personal traits that set you apart, like working under pressure, fast learning, analytical thinking, etc."
    },
    {
      "title": "Languages",
      "description":
          "Specify the languages you’re proficient in; you can add more than one with your level in each."
    },
    {
      "title": "Projects",
      "description":
          "Add projects you have worked on (academic, personal, or professional) with title, description, and period."
    },
    {
      "title": "Cover Letter",
      "description":
          "A short letter to the employer explaining who you are and why you’re suitable for the job, usually attached with the résumé."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isArabic = AppLocalizations.of(context)!.localeName == 'ar';
    final sections = isArabic ? _sectionsAr : _sectionsEn;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      isArabic ? "صفحة المساعدة" : "Help Page",
                      style: const TextStyle(
                        color: Color(0xFF8852A8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
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
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: sections.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section["title"]!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              section["description"]!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColor.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
