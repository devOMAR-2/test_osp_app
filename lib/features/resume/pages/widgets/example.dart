import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExampleSection extends StatelessWidget {
  final List<String> names;
  ExampleSection({super.key, required this.names});

  final sections = [
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
      "title": "تفاصيل البيانات الشخصية",
      "description":
          "📌 اسمك الكامل\nاكتب اسمك الثلاثي كما يظهر في الوثائق الرسمية.\nتأكد من وضوح الاسم وكتابته بخط مناسب في أعلى السيرة الذاتية.\n\n🧑‍💼 المسمى الوظيفي (الوظيفة الحالية أو المرغوبة)\nحدد الوظيفة التي تعمل بها حاليًا أو الوظيفة التي تستهدفها.\nمثال: مطور تطبيقات Flutter، أخصائي تسويق رقمي.\n\n📞 رقم الهاتف\nاكتب رقم هاتفك مع مفتاح الدولة.\nتأكد من صحته لأنه وسيلة التواصل الأساسية.\n\n✉️ البريد الإلكتروني\nاستخدم بريدًا إلكترونيًا رسميًا واحترافيًا.\nتجنب الأسماء غير المهنية (مثل: lovelygirl@...).\n\n🌐 رابط الموقع الشخصي أو محفظة الأعمال (Portfolio)\nإذا كان لديك موقع يعرض أعمالك أو سيرتك الذاتية، أضف رابطه.\nيمكن أن يكون GitHub، Behance، LinkedIn، أو موقع خاص بك.\n\n📝 النبذة الشخصية\nفقرة قصيرة من 3 إلى 4 أسطر تُلخص من أنت، خبراتك، وأهدافك المهنية.\nاجعلها جذابة وواقعية وتعكس شخصيتك المهنية.\n\n🖼️ الصورة الشخصية\nصورة رسمية بخلفية هادئة، يُفضل أن تكون حديثة.\nاحرص على أن تكون ذات جودة جيدة وتُظهر ملامحك بوضوح."
    },
    {
      "title": "التعليم",
      "description":
          "أضف الجامعات أو المعاهد التي التحقت بها، تواريخ البدء والانتهاء، والتخصص الدراسي. يمكنك تحديد أنك لا تزال تدرس."
    },
    {
      "title": "بكالوريوس إدارة أعمال",
      "description":
          "جامعة الإمام - الرياض | المعدل التراكمي: 5.0 | سنة التخرج: 2016"
    },
    {
      "title": "تقنية معلومات",
      "description":
          "جامعة الأميرة نورة - الرياض | المعدل التراكمي: 5.0 | سنة التخرج: 2019"
    },
    {
      "title": "الخبرات العملية",
      "description":
          "أضف الوظائف السابقة أو الحالية التي عملت بها، مع تحديد المسمى الوظيفي، اسم الشركة، المدة الزمنية، والمسؤوليات الرئيسية."
    },
    {
      "title": "الخبرات العملية الشخصية",
      "description":
          "💼 الخبرات العملية\n🏢 اسم الشركة\nاكتب اسم الشركة أو المؤسسة التي عملت بها.\nمثال: شركة XYZ لتقنية المعلومات، بنك الرياض، مدارس النخبة.\n\n👨‍💻 المسمى الوظيفي\nحدد المسمى الدقيق للوظيفة.\n\n📆 تاريخ البداية والنهاية\nاكتب تاريخ الالتحاق والمغادرة أو حدد أنك تعمل حاليًا.\n\n🧾 المسؤوليات والمهام\nاكتب النقاط الأساسية التي كنت تقوم بها في هذه الوظيفة.\n\n✅ ملاحظات إضافية\n- رتب الخبرات من الأحدث إلى الأقدم.\n- لا تكتفِ بكتابة اسم الوظيفة فقط، بل وضّح ما كنت تقوم به."
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
          "يمكنك إضافة مشاريع عملت عليها، مع توضيح المسمى والوصف والفترة الزمنية."
    },
    {
      "title": "الخطاب التعريفي (Cover Letter)",
      "description":
          "هو نص مختصر توجهه لصاحب العمل لتشرح فيه من أنت، ولماذا أنت مناسب لهذه الوظيفة."
    },
  ];

  final sections2 = [
    {
      "title": "مقدمة",
      "description":
          "Welcome to the help page! Here, you'll learn about each section of the resume and how to fill it out professionally."
    },
    {
      "title": "البيانات الشخصية",
      "description":
          "Add your name, current or desired job title, phone number, email, and a portfolio link if available. Don’t forget to include a short personal summary."
    },
    {
      "title": "تفاصيل البيانات الشخصية",
      "description":
          "📌 Full Name\nWrite your full legal name.\n\n🧑‍💼 Job Title\nState your current or desired job.\n\n📞 Phone Number\nInclude with country code.\n\n✉️ Email Address\nUse a professional one.\n\n🌐 Portfolio\nAdd if available.\n\n📝 Summary\nShort and to the point.\n\n🖼️ Profile Picture\nClear and professional."
    },
    {
      "title": "التعليم",
      "description":
          "Include universities or institutions you attended, dates, and your major."
    },
    {
      "title": "بكالوريوس إدارة أعمال",
      "description": "Imam University - Riyadh | GPA: 5.0 | Year: 2016"
    },
    {
      "title": "تقنية معلومات",
      "description":
          "Princess Nourah University - Riyadh | GPA: 5.0 | Year: 2019"
    },
    {
      "title": "الخبرات العملية",
      "description":
          "List previous or current jobs, including job title, company, duration, and key responsibilities."
    },
    {
      "title": "الخبرات العملية الشخصية",
      "description":
          "💼 Work Experience\n🏢 Company Name\n👨‍💻 Job Title\n📆 Dates\n🧾 Responsibilities\n✅ Notes"
    },
    {
      "title": "المهارات",
      "description":
          "List your technical or soft skills, such as Flutter, teamwork, leadership..."
    },
    {
      "title": "القدرات",
      "description":
          "Traits like working under pressure, fast learning, analytical thinking..."
    },
    {
      "title": "اللغات",
      "description": "Mention the languages you are proficient in."
    },
    {
      "title": "المشاريع",
      "description":
          "Add academic, personal, or professional projects with title, description, and duration."
    },
    {
      "title": "الخطاب التعريفي (Cover Letter)",
      "description":
          "A short letter to the employer about who you are and why you're suitable for the job."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final locale = AppLocalizations.of(context)!.localeName;
    final isArabic = locale == 'ar';
    final activeSections = isArabic ? sections : sections2;
    final matchingSections = activeSections
        .where((section) => names.contains(section["title"]))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                themeProvider.isDarkMode
                    ? const Color.fromARGB(204, 70, 69, 69)
                    : const Color(0xFFEEDBED),
                themeProvider.isDarkMode
                    ? const Color.fromARGB(204, 173, 172, 172)
                    : Colors.white,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                AppLocalizations.of(context)!.examples,
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.white
                      : AppColor.primary,
                ),
              ),
            ),
          ),
        ),

        // الكروت
        ...matchingSections.map(
          (section) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: Card(
                color: themeProvider.isDarkMode
                    ? const Color.fromARGB(255, 78, 78, 78)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: AppColor.primary2,
                    width: 1,
                  ),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   section["title"]!,
                      //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      //         fontWeight: FontWeight.bold,
                      //         color: themeProvider.isDarkMode
                      //             ? Colors.white
                      //             : AppColor.primary,
                      //       ),
                      // ),
                      const SizedBox(height: 8),
                      Text(
                        section["description"]!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : AppColor.primary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
