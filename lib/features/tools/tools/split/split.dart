import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import 'package:osp/features/tools/tools/split/widgets/deletepages.dart';
import 'package:osp/features/tools/tools/split/widgets/rangesplit.dart';
import '../../widgets/customappbar.dart';
import '../../../auth/widgets/custom_button.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplitPdf extends StatefulWidget {
  // final String pdfFilePath;
  final List<File> selectedFiles;
  const SplitPdf({super.key, required this.selectedFiles});

  @override
  State<SplitPdf> createState() => _SplitPdfState();
}

class _SplitPdfState extends State<SplitPdf> {
  bool extractAll = false;

  @override
  Widget build(BuildContext context) {
    // final file = File(widget.pdfFilePath);

    final bool isSplitEnabled = extractAll;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppBar(
                title: AppLocalizations.of(context)!.splitPdfTitle,
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              _buildNavigationItem(
                context,
                AppLocalizations.of(context)!.splitByRange,
                'assets/images/arrow.png',
                () {
                  if (!extractAll) {
                    final path = widget.selectedFiles.first.path;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RangeSplit(pdfFilePath: path),
                      ),
                    );
                  }
                },
                enabled: !extractAll,
              ),
              const SizedBox(height: 4),
              _buildSubText(
                AppLocalizations.of(context)!.addCustomRanges,
              ),

              const SizedBox(height: 60),
              _buildNavigationItem(
                context,
                AppLocalizations.of(context)!.fixedRange,
                'assets/images/arrow.png',
                () {
                  if (!extractAll) {
                    //  final path = widget.selectedFiles.first.path;
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => FixedRange(file: path),
                    //   ),
                    // );
                  }
                },
                enabled: !extractAll,
              ),
              const SizedBox(height: 4),
              _buildSubText(
                AppLocalizations.of(context)!.setFixedInterval,
              ),

              const SizedBox(height: 60),
              _buildNavigationItem(
                context,
                AppLocalizations.of(context)!.deletePages,
                'assets/images/arrow.png',
                () {
                  if (!extractAll) {
                    final path = widget.selectedFiles.first.path;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeletePages(pdfFilePath: path),
                      ),
                    );
                  }
                },
                enabled: !extractAll,
              ),
              const SizedBox(height: 4),
              _buildSubText(
                AppLocalizations.of(context)!.deleteSpecificPages,
              ),

              const SizedBox(height: 60),

              // استخراج جميع الصفحات
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: extractAll,
                    onChanged: (bool? value) {
                      setState(() {
                        extractAll = value ?? false;
                      });
                    },
                    checkColor: const Color(0xD78852A8),
                    fillColor: WidgetStateProperty.all(
                      const Color(0xFFFFFFFF).withOpacity(0.8),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.extractAllPages,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xD78852A8),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 4),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            AppLocalizations.of(context)!.extractAllPagesHint,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8852A8),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: isSplitEnabled ? 1.0 : 0.2,
                    child: IgnorePointer(
                      ignoring: !isSplitEnabled,
                      child: CustomButton(
                        width: 180,
                        height: 50,
                        text: AppLocalizations.of(context)!.splitPdfButton,
                        onPressed: () {
                          print(
                              '${AppLocalizations.of(context)!.splitPdfButton}: ${widget.selectedFiles.toString()}');

                          final path = widget.selectedFiles.first.path;
                          CloudmersiveConverter.extractPagesToSeparatePdfs(
                              context, path);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context,
    String title,
    String arrowAsset,
    VoidCallback onTap, {
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              arrowAsset,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xD78852A8),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubText(String text) {
    return Opacity(
      opacity: 0.5,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF8852A8),
        ),
      ),
    );
  }
}
