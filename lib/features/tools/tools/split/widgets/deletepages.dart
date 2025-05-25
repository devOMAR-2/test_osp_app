import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import '../../../widgets/customappbar.dart';
import '../../../../auth/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeletePages extends StatefulWidget {
  final String pdfFilePath; // غير قابل للـ null
  const DeletePages({super.key, required this.pdfFilePath});

  @override
  State<DeletePages> createState() => _DeletePagesState();
}

class _DeletePagesState extends State<DeletePages> {
  final List<Map<String, dynamic>> ranges = []; // {fromCtrl,toCtrl,index}
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    _addRange(); // نطاق افتراضي واحد
    // TODO: احسب totalPages إن شئت
  }

  /*───────────────── helpers ─────────────────*/

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
    if (ranges.isEmpty) return false;
    for (final r in ranges) {
      final f = int.tryParse(r['fromCtrl'].text);
      final t = int.tryParse(r['toCtrl'].text);
      if (f == null || t == null || f <= 0 || t < f) return false;
    }
    return true;
  }

  /*───────────────── API call ───────────────*/

  Future<void> _deletePages() async {
    if (!_validateRanges()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('تحقّق من أن جميع النطاقات صحيحة وأن النهاية ≥ البداية')));
      return;
    }

    // تحويل النطاقات إلى قائمة أرقام صفحات منفردة
    final List<int> pages = [];
    for (final r in ranges) {
      final from = int.parse(r['fromCtrl'].text);
      final to = int.parse(r['toCtrl'].text);
      pages.addAll(List.generate(to - from + 1, (i) => from + i));
    }

    try {
      print(widget.pdfFilePath);
      print(pages);
      await CloudmersiveConverter.deletePdfPages(
        context,
        widget.pdfFilePath,
        pages,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم الحذف وحفظ الملف الجديد')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('فشل: $e')));
      }
    }
  }

  /*───────────────── UI ─────────────────────*/

  @override
  Widget build(BuildContext context) {
    final canDelete = _validateRanges();

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.deletePages,
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
                        '${AppLocalizations.of(context)!.totalPages} $totalPages',
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xD78852A8))),
                  ),
                  const SizedBox(height: 20),

                  //‑‑‑ قائمة النطاقات
                  ...List.generate(ranges.length, (i) {
                    final r = ranges[i];
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${AppLocalizations.of(context)!.range} ${r['index']}',
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
                                  decoration: InputDecoration(
                                      labelText:
                                          '${AppLocalizations.of(context)!.fromPage}:',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: r['toCtrl'],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                      labelText:
                                          '${AppLocalizations.of(context)!.toPage}:',
                                      border: OutlineInputBorder()),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!.addRange,
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

          //‑‑‑ زر الحذف
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Opacity(
                opacity: canDelete ? 1 : 0.3,
                child: IgnorePointer(
                  ignoring: !canDelete,
                  child: CustomButton(
                    width: 180,
                    height: 50,
                    text: AppLocalizations.of(context)!.delete,
                    onPressed: _deletePages,
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
