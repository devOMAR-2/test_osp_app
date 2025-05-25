import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import '../../../widgets/customappbar.dart';
import '../../../../auth/widgets/custom_button.dart';

class RangeSplit extends StatefulWidget {
  /// مسار ملف PDF المُختار (غير قابل للـ null)
  final String pdfFilePath;

  const RangeSplit({super.key, required this.pdfFilePath});

  @override
  State<RangeSplit> createState() => _RangeSplitState();
}

class _RangeSplitState extends State<RangeSplit> {
  final List<Map<String, dynamic>> ranges = []; // [ {from,to,index,ctrls…} ]
  int totalPages = 0; // املأه لاحقًا إذا أردت إظهار العدد الحقيقي

  @override
  void initState() {
    super.initState();
    _addRange(); // نطاق افتراضي واحد
    // TODO: اجلب totalPages إن أردت
  }

  /*────────────────────────── helpers ──────────────────────────*/

  void _addRange() {
    setState(() {
      ranges.add({
        'index': ranges.length + 1,
        'fromCtrl': TextEditingController(),
        'toCtrl': TextEditingController(),
      });
    });
  }

  void _removeRange(int i) {
    setState(() {
      ranges.removeAt(i);
      for (var j = 0; j < ranges.length; j++) ranges[j]['index'] = j + 1;
    });
  }

  bool _validateRanges() {
    for (final r in ranges) {
      final f = int.tryParse(r['fromCtrl'].text);
      final t = int.tryParse(r['toCtrl'].text);
      if (f == null || t == null || f <= 0 || t <= f) return false;
    }
    return ranges.isNotEmpty;
  }

  /*──────────────────────────── API ────────────────────────────*/

  Future<void> _splitPdf() async {
    if (!_validateRanges()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'تحقق من أن جميع النطاقات صحيحة وأن النهاية أكبر من البداية')));
      return;
    }

    try {
      for (final r in ranges) {
        final from = int.parse(r['fromCtrl'].text);
        final to = int.parse(r['toCtrl'].text);

        await CloudmersiveConverter.splitPdfByRange(
          context,
          widget.pdfFilePath,
          from: from,
          to: to,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التقسيم بنجاح وحُفظت الملفات')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('فشل: $e')));
      }
    }
  }

  /*────────────────────────── UI ───────────────────────────────*/

  @override
  Widget build(BuildContext context) {
    final canSplit = _validateRanges();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'التقسيم باستخدام النطاق',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      'إجمالي عدد الصفحات: $totalPages',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xD78852A8)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //‑‑‑‑‑‑‑ قائمة النطاقات
                  ...List.generate(ranges.length, (i) {
                    final r = ranges[i];
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('النطاق ${r['index']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xD78852A8))),
                              IconButton(
                                  onPressed: () => _removeRange(i),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: r['fromCtrl'],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    labelText: 'من الصفحة رقم:',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: r['toCtrl'],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    labelText: 'إلى الصفحة رقم:',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }),

                  // زر إضافة نطاق
                  GestureDetector(
                    onTap: _addRange,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('إضافة نطاق',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xD4FB8006))),
                        SizedBox(width: 4),
                        Icon(Icons.add, color: Color(0xD4FB8006)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // زر التقسيم
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Opacity(
                opacity: canSplit ? 1 : 0.3,
                child: IgnorePointer(
                  ignoring: !canSplit,
                  child: CustomButton(
                    width: 180,
                    height: 50,
                    text: 'تقسيم',
                    onPressed: _splitPdf,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
