import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OcrResultScreen extends StatelessWidget {
  final String extractedText;

  const OcrResultScreen({super.key, required this.extractedText});

  Future<void> _saveAsPdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Text(extractedText, textDirection: pw.TextDirection.rtl);
        },
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final file = File("${outputDir.path}/ocr_result.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الملف كـ PDF!')),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.share),
            title: Text(AppLocalizations.of(context)!.share),
            onTap: () {
              Navigator.pop(context);
              Share.share(extractedText);
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(
              AppLocalizations.of(context)!.saveaspdf,
            ),
            onTap: () {
              Navigator.pop(context);
              _saveAsPdf(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordCount = extractedText.trim().split(RegExp(r'\s+')).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // العنوان وزر العودة والنسخ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Image.asset(
                      'assets/images/back.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.extractedText,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8852A8)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    tooltip: AppLocalizations.of(context)!.textCopy,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: extractedText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                          AppLocalizations.of(context)!.textCopyDone,
                        )),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // عدد الكلمات
              Row(
                children: [
                  const Icon(Icons.text_snippet, color: Color(0xFF8852A8)),
                  const SizedBox(width: 8),
                  Text(
                    "${AppLocalizations.of(context)!.noOfwords} : $wordCount",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // النص المستخرج
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      extractedText,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.7,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // زر المشاركة/الحفظ
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8852A8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.share, color: Colors.white),
                label: Text(
                  AppLocalizations.of(context)!.share,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => _showShareOptions(context),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
