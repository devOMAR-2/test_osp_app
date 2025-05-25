// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:osp/core/api/converter.dart';
// import 'package:osp/core/theme/app_color.dart';
// import 'package:osp/core/theme/theme_provider.dart';
// import 'package:osp/features/ocr/ocr_home_screen.dart';
// import 'package:osp/features/tools/tools/split/split.dart';
// import 'package:osp/features/tools/tools/standard.dart';
// import 'package:provider/provider.dart';
// import '../../auth/widgets/custom_button.dart';
// import '../../PDFViewer.dart';
// import '../tools/merge/merge.dart';
// import '../tools/watermark.dart';
// import '../../repair.dart';
// import '../../sign.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// // صفحة عرض قائمة الملفات
// class FilesListScreen extends StatefulWidget {
//   final List<FileSystemEntity> files;
//   final String folderName;
//   final List<File> selectedFiles;
//   final String selectedTool;
//   final Function(FileSystemEntity file, bool isSelected) onFileSelected;

//   const FilesListScreen({
//     super.key,
//     required this.files,
//     required this.folderName,
//     required this.onFileSelected,
//     required this.selectedFiles,
//     required this.selectedTool,
//   });

//   @override
//   State<FilesListScreen> createState() => _FilesListScreenState();
// }

// class _FilesListScreenState extends State<FilesListScreen> {
//   bool isBottomSheetExpanded = false;

//   // توسيع/طي القائمة السفلية
//   void toggleBottomSheet() {
//     setState(() {
//       isBottomSheetExpanded = !isBottomSheetExpanded;
//     });
//   }

//   // التحقق مما إذا كان الملف مُختار أو لا
//   bool isSelected(FileSystemEntity file) {
//     return widget.selectedFiles.any((f) => f.path == file.path);
//   }

//   // تحديد ما إذا كان بالإمكان اختيار ملفات إضافية
//   bool canSelectMore() {
//     if (widget.selectedTool == 'دمج' || widget.selectedTool == 'Merge')
//       return true; // لأداة الدمج يُسمح بأكثر من ملف
//     if (widget.selectedTool == 'تقسيم' && widget.selectedFiles.isEmpty)
//       return true;
//     return widget.selectedFiles.isEmpty; // لأدوات التقسيم يُسمح بملف واحد فقط
//   }

//   // عرض أيقونة الملف تبعاً لنوعه
//   // Widget getFileIcon(FileSystemEntity file) {
//   //   final realFile = File(file.path);
//   //   if (file is File) {
//   //     if (realFile.path.endsWith('.jpg') ||
//   //         realFile.path.endsWith('.jpeg') ||
//   //         realFile.path.endsWith('.png')) {
//   //       return Image.file(realFile, width: 60, height: 60, fit: BoxFit.cover);
//   //     } else if (realFile.path.endsWith('.pdf')) {
//   //       // هنا يتم تمرير الملف إلى شاشة عرض PDF (PDFViewerScreen)
//   //       return SizedBox(
//   //           height: 60,
//   //           width: 60,
//   //           child: PDFViewerScreen(filePath: realFile.path));
//   //     }
//   //   }
//   //   return const Icon(Icons.insert_drive_file, color: Colors.purple, size: 60);
//   // }

//   Widget getFileIcon(FileSystemEntity file) {
//     final f = File(file.path);
//     final path = f.path.toLowerCase();

//     // صور (مع fallback إذا كانت تالفة)
//     if (file is File &&
//         (path.endsWith('.jpg') ||
//             path.endsWith('.jpeg') ||
//             path.endsWith('.png'))) {
//       return Image.file(
//         f,
//         width: 60,
//         height: 60,
//         fit: BoxFit.cover,
//         errorBuilder: (_, __, ___) => const Icon(
//           Icons.broken_image,
//           color: Colors.purple,
//           size: 60,
//         ),
//       );
//     }

//     // ملفات PDF
//     if (file is File && path.endsWith('.pdf')) {
//       return SizedBox(
//         width: 60,
//         height: 60,
//         child: PDFViewerScreen(filePath: f.path),
//       );
//     }

//     // أي نوع آخر
//     return const Icon(Icons.insert_drive_file, color: Colors.purple, size: 60);
//   }

//   bool isSelectionValid() {
//     final count = widget.selectedFiles.length;
//     final tool = widget.selectedTool;
//     if (tool == 'دمج' || tool == "Merge") return count > 1;
//     if (tool == 'تقسيم' || tool == "Split") return count == 1;
//     return count >= 1;
//   }

//   void navigateToToolPage() {
//     final tool = widget.selectedTool;
//     if (tool == 'دمج' || tool == "Merge") {
//       print("دمج");
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => MergePdf(
//             selectedFiles:
//                 widget.selectedFiles.map((file) => file.path).toList(),
//           ),
//         ),
//       );
//     } else if (tool == 'تقسيم' || tool == "Split") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => SplitPdf(selectedFiles: widget.selectedFiles)));
//     } else if (tool == 'ضغط' || tool == "Compress") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "Compress",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.compressSingleFileToZip(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == 'اصلاح مستند') {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) =>
//                   DocumentRepairScreen(selectedFiles: widget.selectedFiles)));
//     } else if (tool == 'توقيع مستند') {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) =>
//                   DocumentSignScreen(selectedFiles: widget.selectedFiles)));
//     }
//     //start of basic processes
//     else if (tool == 'PDF إلى Word' || tool == "PDF to Word") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: 'PDF إلى Word',
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPdfToWord(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == 'PDF إلى بوربوينت' || tool == "PDF to PowerPoint") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: 'PDF إلى بوربوينت',
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPdfToPpt(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == 'PDF إلى إكسل' || tool == "PDF to Excel") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: 'PDF إلى إكسل',
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPdfToExcel(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     }
//     //start of inverse process
//     else if (tool == "وورد إلى PDF" || tool == "Word to PDF") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "Word to PDF",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertWordToPdf(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == "بوربوينت إلى PDF" || tool == "PowerPoint to PDF") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "PowerPoint to PDF",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPptToPdf(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == "إكسل إلى PDF" || tool == "Excel to PDF") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "Excel to PDF",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertExcelToPdf(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     }
//     // end of inverse process
//     else if (tool == 'pdf إلى jpg' || tool == "PDF to JPG") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "PDF to JPG",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPdfToJpg(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == 'pdf إلى صورة' || tool == "PDF to Image") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "PDF to Image",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPdfToJpg(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else if (tool == 'OCR') {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => const OcrHomeScreen()));
//     } else if (tool == 'العلامة المائية' || tool == "Watermark") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => WatermarkScreen(
//                     selectedFiles: widget.selectedFiles,
//                   )));
//     } else if (tool == "تحويل إلى صورة" || tool == "Image to PDF") {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => Standard(
//                     name: "PNG to PDF",
//                     selectedFiles: widget.selectedFiles,
//                     func: () {
//                       CloudmersiveConverter.convertPngToPdf(
//                         context,
//                         widget.selectedFiles.first.path,
//                       );
//                     },
//                   )));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//         AppLocalizations.of(context)!.unsupportedTool,
//       )));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: SafeArea(
//         child: Scaffold(
//           // backgroundColor: Colors.white,
//           // appBar: AppBar(
//           //   title: Text(widget.folderName),
//           //   centerTitle: true,
//           //   backgroundColor: Colors.white,
//           //   elevation: 0,
//           //   foregroundColor: Colors.black,
//           // ),
//           body: Stack(
//             children: [
//               // عرض قائمة الملفات الرئيسية مع هامش سفلي للنافذة السفلية
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 120),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 0.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 20.0),
//                             child: Text(widget.folderName,
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.purple)),
//                           ),
//                           GestureDetector(
//                             onTap: () => Navigator.pop(context),
//                             child: Image.asset('assets/images/back.png',
//                                 width: 100, height: 100),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: widget.files.length,
//                         itemBuilder: (context, index) {
//                           final file = widget.files[index];
//                           final fileName = file.path.split('/').last;
//                           final selected = isSelected(file);
//                           return AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                             margin: const EdgeInsets.symmetric(vertical: 6),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: selected
//                                   ? Colors.lightGreen[100]
//                                   : themeProvider.isDarkMode
//                                       ? const Color.fromARGB(255, 73, 73, 73)
//                                       : Colors.white,
//                               boxShadow: selected
//                                   ? [
//                                       BoxShadow(
//                                           color: Colors.green.shade200,
//                                           blurRadius: 4,
//                                           spreadRadius: 2)
//                                     ]
//                                   : null,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: ListTile(
//                               leading: getFileIcon(file),
//                               title: Text(fileName,
//                                   textDirection: TextDirection.rtl),
//                               onTap: () {
//                                 setState(() {
//                                   if (selected) {
//                                     widget.onFileSelected(file, false);
//                                   } else if (canSelectMore()) {
//                                     widget.onFileSelected(file, true);
//                                   }
//                                 });
//                               },
//                               // onTap: () {
//                               //   setState(() {
//                               //     widget.selectedFiles.clear();
//                               //     widget.onFileSelected(file, true);
//                               //   });
//                               // },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // النافذة السفلية التي تعرض الملفات المختارة وزر "التالي"
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   height: isBottomSheetExpanded ? 400 : 200,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: themeProvider.isDarkMode
//                         ? AppColor.darkmode
//                         : Colors.white,
//                     boxShadow: [
//                       BoxShadow(blurRadius: 10, color: Colors.black12)
//                     ],
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: toggleBottomSheet,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               isBottomSheetExpanded
//                                   ? Icons.keyboard_arrow_down
//                                   : Icons.keyboard_arrow_up,
//                               color: Colors.purple,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               '${AppLocalizations.of(context)!.selected} ${widget.selectedFiles.length} ${widget.selectedFiles.length == 1 ? AppLocalizations.of(context)!.files : AppLocalizations.of(context)!.files}',
//                               style: const TextStyle(color: Colors.purple),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: widget.selectedFiles.length,
//                           itemBuilder: (context, index) {
//                             final file = widget.selectedFiles[index];
//                             final fileName = file.path.split('/').last;
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 6.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.lightGreen[100],
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 6, horizontal: 8),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.close,
//                                           color: Colors.red, size: 20),
//                                       onPressed: () {
//                                         setState(() {
//                                           widget.selectedFiles.removeAt(index);
//                                         });
//                                       },
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         fileName,
//                                         style: const TextStyle(
//                                             color: Colors.black87),
//                                         textAlign: TextAlign.right,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       // زر "التالي"؛ هنا يُفعل الزر فقط إذا كانت الاختيارات صالحة
//                       CustomButton(
//                           width: double.infinity,
//                           height: 50,
//                           text: AppLocalizations.of(context)!.next,
//                           onPressed:
//                               isSelectionValid() ? navigateToToolPage : null,
//                           color: isSelectionValid()
//                               ? Colors.grey.shade300
//                               : Colors.purple,
//                           textColor:
//                               isSelectionValid() ? Colors.grey : Colors.white),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/ocr/ocr_home_screen.dart';
import 'package:osp/features/tools/tools/split/split.dart';
import 'package:osp/features/tools/tools/standard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/widgets/custom_button.dart';
import '../../PDFViewer.dart';
import '../tools/merge/merge.dart';
import '../tools/watermark.dart';
import '../../repair.dart';
import '../../sign.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// صفحة عرض قائمة الملفات
class FilesListScreen extends StatefulWidget {
  final List<FileSystemEntity> files;
  final String folderName;
  final List<File> selectedFiles;
  final String selectedTool;
  final Function(FileSystemEntity file, bool isSelected) onFileSelected;

  const FilesListScreen({
    super.key,
    required this.files,
    required this.folderName,
    required this.onFileSelected,
    required this.selectedFiles,
    required this.selectedTool,
  });

  @override
  State<FilesListScreen> createState() => _FilesListScreenState();
}

class _FilesListScreenState extends State<FilesListScreen> {
  bool isBottomSheetExpanded = false;

  // توسيع/طي القائمة السفلية
  void toggleBottomSheet() {
    setState(() {
      isBottomSheetExpanded = !isBottomSheetExpanded;
    });
  }

  // التحقق مما إذا كان الملف مُختار أو لا
  bool isSelected(FileSystemEntity file) {
    return widget.selectedFiles.any((f) => f.path == file.path);
  }

  // تحديد ما إذا كان بالإمكان اختيار ملفات إضافية
  bool canSelectMore() {
    if (widget.selectedTool == 'دمج' || widget.selectedTool == 'Merge')
      return true; // لأداة الدمج يُسمح بأكثر من ملف
    if (widget.selectedTool == 'تقسيم' && widget.selectedFiles.isEmpty)
      return true;
    return widget.selectedFiles.isEmpty; // لأدوات التقسيم يُسمح بملف واحد فقط
  }

  // عرض أيقونة الملف تبعاً لنوعه
  // Widget getFileIcon(FileSystemEntity file) {
  //   final realFile = File(file.path);
  //   if (file is File) {
  //     if (realFile.path.endsWith('.jpg') ||
  //         realFile.path.endsWith('.jpeg') ||
  //         realFile.path.endsWith('.png')) {
  //       return Image.file(realFile, width: 60, height: 60, fit: BoxFit.cover);
  //     } else if (realFile.path.endsWith('.pdf')) {
  //       // هنا يتم تمرير الملف إلى شاشة عرض PDF (PDFViewerScreen)
  //       return SizedBox(
  //           height: 60,
  //           width: 60,
  //           child: PDFViewerScreen(filePath: realFile.path));
  //     }
  //   }
  //   return const Icon(Icons.insert_drive_file, color: Colors.purple, size: 60);
  // }

  Future<void> saveSelectedFiles(List<File> selectedFiles) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> filePaths = selectedFiles.map((file) => file.path).toList();
    await prefs.setStringList('selectedFiles', filePaths);
  }

  Widget getFileIcon(FileSystemEntity file) {
    final f = File(file.path);
    final path = f.path.toLowerCase();

    // صور (مع fallback إذا كانت تالفة)
    if (file is File &&
        (path.endsWith('.jpg') ||
            path.endsWith('.jpeg') ||
            path.endsWith('.png'))) {
      return Image.file(
        f,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(
          Icons.broken_image,
          color: Colors.purple,
          size: 60,
        ),
      );
    }

    // ملفات PDF
    if (file is File && path.endsWith('.pdf')) {
      return SizedBox(
        width: 60,
        height: 60,
        child: PDFViewerScreen(filePath: f.path),
      );
    }

    // أي نوع آخر
    return const Icon(Icons.insert_drive_file, color: Colors.purple, size: 60);
  }

  bool isSelectionValid() {
    final count = widget.selectedFiles.length;
    final tool = widget.selectedTool;
    if (tool == 'دمج' || tool == "Merge") return count > 1;
    if (tool == 'تقسيم' || tool == "Split") return count == 1;
    return count >= 1;
  }

  void navigateToToolPage() async {
    await saveSelectedFiles(widget.selectedFiles);
    final tool = widget.selectedTool;
    if (tool == 'دمج' || tool == "Merge") {
      print("دمج");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MergePdf(
            selectedFiles:
                widget.selectedFiles.map((file) => file.path).toList(),
          ),
        ),
      );
    } else if (tool == 'تقسيم' || tool == "Split") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SplitPdf(selectedFiles: widget.selectedFiles)));
    } else if (tool == 'ضغط' || tool == "Compress") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "Compress",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.compressSingleFileToZip(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == 'اصلاح مستند') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  DocumentRepairScreen(selectedFiles: widget.selectedFiles)));
    } else if (tool == 'توقيع مستند') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  DocumentSignScreen(selectedFiles: widget.selectedFiles)));
    }
    //start of basic processes
    else if (tool == 'PDF إلى Word' || tool == "PDF to Word") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: 'PDF إلى Word',
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPdfToWord(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == 'PDF إلى بوربوينت' || tool == "PDF to PowerPoint") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: 'PDF إلى بوربوينت',
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPdfToPpt(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == 'PDF إلى إكسل' || tool == "PDF to Excel") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: 'PDF إلى إكسل',
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPdfToExcel(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    }
    //start of inverse process
    else if (tool == "وورد إلى PDF" || tool == "Word to PDF") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "Word to PDF",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertWordToPdf(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == "بوربوينت إلى PDF" || tool == "PowerPoint to PDF") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "PowerPoint to PDF",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPptToPdf(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == "إكسل إلى PDF" || tool == "Excel to PDF") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "Excel to PDF",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertExcelToPdf(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    }
    // end of inverse process
    else if (tool == 'pdf إلى jpg' || tool == "PDF to JPG") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "PDF to JPG",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPdfToJpg(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == 'pdf إلى صورة' || tool == "PDF to Image") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "PDF to Image",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPdfToJpg(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else if (tool == 'OCR') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const OcrHomeScreen()));
    } else if (tool == 'العلامة المائية' || tool == "Watermark") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => WatermarkScreen(
                    selectedFiles: widget.selectedFiles,
                  )));
    } else if (tool == "تحويل إلى صورة" || tool == "Image to PDF") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Standard(
                    name: "PNG to PDF",
                    selectedFiles: widget.selectedFiles,
                    func: () {
                      CloudmersiveConverter.convertPngToPdf(
                        context,
                        widget.selectedFiles.first.path,
                      );
                    },
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(context)!.unsupportedTool,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.white,
          // appBar: AppBar(
          //   title: Text(widget.folderName),
          //   centerTitle: true,
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   foregroundColor: Colors.black,
          // ),
          body: Stack(
            children: [
              // عرض قائمة الملفات الرئيسية مع هامش سفلي للنافذة السفلية
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(widget.folderName,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.purple)),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset('assets/images/back.png',
                                width: 100, height: 100),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.files.length,
                        itemBuilder: (context, index) {
                          final file = widget.files[index];
                          final fileName = file.path.split('/').last;
                          final selected = isSelected(file);
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colors.lightGreen[100]
                                  : themeProvider.isDarkMode
                                      ? const Color.fromARGB(255, 73, 73, 73)
                                      : Colors.white,
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                          color: Colors.green.shade200,
                                          blurRadius: 4,
                                          spreadRadius: 2)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: getFileIcon(file),
                              title: Text(fileName,
                                  textDirection: TextDirection.rtl),
                              onTap: () {
                                setState(() {
                                  if (selected) {
                                    widget.onFileSelected(file, false);
                                  } else if (canSelectMore()) {
                                    widget.onFileSelected(file, true);
                                  }
                                });
                              },
                              // onTap: () {
                              //   setState(() {
                              //     widget.selectedFiles.clear();
                              //     widget.onFileSelected(file, true);
                              //   });
                              // },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // النافذة السفلية التي تعرض الملفات المختارة وزر "التالي"
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isBottomSheetExpanded ? 400 : 200,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? AppColor.darkmode
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 10, color: Colors.black12)
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: toggleBottomSheet,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              isBottomSheetExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${AppLocalizations.of(context)!.selected} ${widget.selectedFiles.length} ${widget.selectedFiles.length == 1 ? AppLocalizations.of(context)!.files : AppLocalizations.of(context)!.files}',
                              style: const TextStyle(color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.selectedFiles.length,
                          itemBuilder: (context, index) {
                            final file = widget.selectedFiles[index];
                            final fileName = file.path.split('/').last;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.red, size: 20),
                                      onPressed: () {
                                        setState(() {
                                          widget.selectedFiles.removeAt(index);
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        fileName,
                                        style: const TextStyle(
                                            color: Colors.black87),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // زر "التالي"؛ هنا يُفعل الزر فقط إذا كانت الاختيارات صالحة
                      CustomButton(
                          width: double.infinity,
                          height: 50,
                          text: AppLocalizations.of(context)!.next,
                          onPressed:
                              isSelectionValid() ? navigateToToolPage : null,
                          color: isSelectionValid()
                              ? Colors.grey.shade300
                              : Colors.purple,
                          textColor:
                              isSelectionValid() ? Colors.grey : Colors.white),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
