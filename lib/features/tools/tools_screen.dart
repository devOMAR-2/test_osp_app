// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:osp/core/theme/app_color.dart';
// import 'package:osp/core/theme/theme_provider.dart';
// import 'package:provider/provider.dart';
// import 'widgets/file_picker.dart';
// import 'listmenutoolsscreen.dart';

// class ToolsScreen extends StatefulWidget {
//   const ToolsScreen({super.key});

//   @override
//   State<ToolsScreen> createState() => _ToolsScreenState();
// }

// class _ToolsScreenState extends State<ToolsScreen> {
//   final List<String> selectedFiles = [];

//   bool isSearching = false;
//   String searchQuery = '';

//   late List<PDFTool> pdfTools;
//   late List<PDFTool> filteredTools;

//   @override
//   void initState() {
//     super.initState();
//     pdfTools = [];
//     filteredTools = [];
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     pdfTools = _buildPdfTools(context); // تعتمد على الترجمة
//     filteredTools =
//         pdfTools.where((tool) => _matchesQuery(tool, searchQuery)).toList();
//   }

//   List<PDFTool> _buildPdfTools(BuildContext ctx) => [
//         PDFTool(title: AppLocalizations.of(ctx)!.merge, iconUrl: 'merge.png'),
//         PDFTool(title: AppLocalizations.of(ctx)!.split, iconUrl: 'split.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.compress, iconUrl: 'compress.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.pdfToWord, iconUrl: 'pdf2w.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.pdfToPowerPoint,
//             iconUrl: 'pdf2P.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.pdfToExcel,
//             iconUrl: 'pdf2xcel.png'),
//         //
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.wordToPdf, iconUrl: 'pdf2w.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.powerPointToPdf,
//             iconUrl: 'pdf2P.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.excelToPdf,
//             iconUrl: 'pdf2xcel.png'),
//         //
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.pdfToJpg, iconUrl: 'pdf_2jpg.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.pdfToImage,
//             iconUrl: 'pdf_2jpg.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.watermark,
//             iconUrl: 'watermark.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.imageToPdf,
//             iconUrl: 'pdf_2jpg.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.pageNumbering,
//             iconUrl: 'page-numbering.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.rotatePdf, iconUrl: 'rotate.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.unlockPdf, iconUrl: 'unlock.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.protectPdf,
//             iconUrl: 'protect.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.organizePdf,
//             iconUrl: 'orgnize.png'),
//         // PDFTool(title: AppLocalizations.of(ctx)!., iconUrl: 'fix.png'),
//         PDFTool(title: AppLocalizations.of(ctx)!.signPdf, iconUrl: 'sign.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.createPdf, iconUrl: 'create.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.addText, iconUrl: 'create.png'),
//         PDFTool(title: 'OCR', iconUrl: 'ocr.png'),
//         PDFTool(
//             title: AppLocalizations.of(ctx)!.password, iconUrl: 'unlock.png'),
//       ];

//   bool _matchesQuery(PDFTool tool, String query) =>
//       tool.title.toLowerCase().contains(query.toLowerCase());

//   void updateSearchQuery(String newQuery) {
//     setState(() {
//       searchQuery = newQuery;
//       filteredTools =
//           pdfTools.where((tool) => _matchesQuery(tool, newQuery)).toList();
//     });
//   }

//   void toggleSearchBar() {
//     setState(() {
//       isSearching = !isSearching;
//       searchQuery = '';
//       filteredTools = pdfTools;
//     });
//   }

//   void navigateBasedOnTool(String toolTitle) {
//     // أمثلة: دمج يحتاج ملفين، تقسيم ملف واحد، الخ…
//     final l10n = AppLocalizations.of(context)!;

//     if (toolTitle == l10n.merge) {
//       if (selectedFiles.length >= 2) {
//         Navigator.pushNamed(context, '/merge', arguments: selectedFiles);
//       } else {
//         // _showErrorDialog(l10n.selectTwoFilesFirst(toolTitle));
//       }
//     } else if (toolTitle == l10n.split ||
//         toolTitle == l10n.watermark ||
//         toolTitle == l10n.repairPdf ||
//         toolTitle == l10n.signPdf) {
//       if (selectedFiles.length == 1) {
//         Navigator.pushNamed(context, '/$toolTitle', arguments: selectedFiles);
//       } else {
//         // _showErrorDialog(l10n.selectOneFileFirst(toolTitle));
//       }
//     } else {
//       Navigator.pushNamed(context, '/$toolTitle', arguments: selectedFiles);
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(AppLocalizations.of(context)!.ok),
//           ),
//         ],
//       ),
//     );
//   }

//   /*--------------------------------------------------
//   | واجهة المستخدم                                    |
//   --------------------------------------------------*/
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             _buildHeader(context),
//             if (isSearching) _buildSearchField(),
//             Expanded(child: _buildToolsGrid()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Image.asset('assets/images/Osp logo.png',
//                 width: 70, height: 40, fit: BoxFit.contain),
//           ),
//           Row(
//             children: [
//               InkWell(
//                 onTap: toggleSearchBar,
//                 child: Image.asset('assets/images/searchbutton.png',
//                     width: 90, height: 80),
//               ),
//               InkWell(
//                 child: Image.asset('assets/images/menu.png',
//                     width: 70, height: 70),
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (_) => const ToolsPage())),
//               ),
//               InkWell(
//                 child: Image.asset('assets/images/back.png',
//                     width: 80, height: 80),
//                 onTap: () => Navigator.of(context).pop(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: TextField(
//         onChanged: updateSearchQuery,
//         decoration: InputDecoration(
//           hintText: AppLocalizations.of(context)!.search,
//           prefixIcon: const Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: const Icon(Icons.clear),
//             onPressed: () => updateSearchQuery(''),
//           ),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }

//   Widget _buildToolsGrid() {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 105 / 110,
//         ),
//         itemCount: filteredTools.length,
//         itemBuilder: (_, index) {
//           final tool = filteredTools[index];
//           return PDFToolCard(
//             tool: tool,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => FilePickerScreen(
//                     selectedTool: tool.title,
//                     folderPath: 'path/to/folder',
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class PDFTool {
//   final String title;
//   final String iconUrl;

//   PDFTool({required this.title, required this.iconUrl});
// }

// class PDFToolCard extends StatelessWidget {
//   final PDFTool tool;
//   final VoidCallback onTap;

//   const PDFToolCard({super.key, required this.tool, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: themeProvider.isDarkMode ? AppColor.darkmode : Colors.white,
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: const Color(0xFF909090), width: 0.5),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (tool.iconUrl.isNotEmpty) ...[
//               Image.asset('assets/images/${tool.iconUrl}',
//                   width: 22, height: 22),
//               const SizedBox(height: 8),
//             ],
//             Text(
//               tool.title,
//               style: const TextStyle(fontSize: 12),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/file_picker.dart';
import 'listmenutoolsscreen.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  final List<String> selectedFiles = [];

  bool isSearching = false;
  String searchQuery = '';
  bool isListView = false;

  late List<PDFTool> pdfTools;
  late List<PDFTool> filteredTools;

  @override
  void initState() {
    super.initState();
    pdfTools = [];
    filteredTools = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pdfTools = _buildPdfTools(context); // تعتمد على الترجمة
    filteredTools =
        pdfTools.where((tool) => _matchesQuery(tool, searchQuery)).toList();
  }

  List<PDFTool> _buildPdfTools(BuildContext ctx) => [
        PDFTool(title: AppLocalizations.of(ctx)!.merge, iconUrl: 'merge.png'),
        PDFTool(title: AppLocalizations.of(ctx)!.split, iconUrl: 'split.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.compress, iconUrl: 'compress.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.pdfToWord, iconUrl: 'pdf2w.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.pdfToPowerPoint,
            iconUrl: 'pdf2P.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.pdfToExcel,
            iconUrl: 'pdf2xcel.png'),
        //
        PDFTool(
            title: AppLocalizations.of(ctx)!.wordToPdf, iconUrl: 'pdf2w.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.powerPointToPdf,
            iconUrl: 'pdf2P.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.excelToPdf,
            iconUrl: 'pdf2xcel.png'),
        //
        PDFTool(
            title: AppLocalizations.of(ctx)!.pdfToJpg, iconUrl: 'pdf_2jpg.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.pdfToImage,
            iconUrl: 'pdf_2jpg.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.watermark,
            iconUrl: 'watermark.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.imageToPdf,
            iconUrl: 'pdf_2jpg.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.pageNumbering,
            iconUrl: 'page-numbering.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.rotatePdf, iconUrl: 'rotate.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.unlockPdf, iconUrl: 'unlock.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.protectPdf,
            iconUrl: 'protect.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.organizePdf,
            iconUrl: 'orgnize.png'),
        // PDFTool(title: AppLocalizations.of(ctx)!., iconUrl: 'fix.png'),
        PDFTool(title: AppLocalizations.of(ctx)!.signPdf, iconUrl: 'sign.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.createPdf, iconUrl: 'create.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.addText, iconUrl: 'create.png'),
        // PDFTool(title: 'OCR', iconUrl: 'ocr.png'),
        PDFTool(
            title: AppLocalizations.of(ctx)!.password, iconUrl: 'unlock.png'),
      ];

  bool _matchesQuery(PDFTool tool, String query) =>
      tool.title.toLowerCase().contains(query.toLowerCase());

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      filteredTools =
          pdfTools.where((tool) => _matchesQuery(tool, newQuery)).toList();
    });
  }

  void toggleSearchBar() {
    setState(() {
      isSearching = !isSearching;
      searchQuery = '';
      filteredTools = pdfTools;
    });
  }

  void navigateBasedOnTool(String toolTitle) {
    // أمثلة: دمج يحتاج ملفين، تقسيم ملف واحد، الخ…
    final l10n = AppLocalizations.of(context)!;

    if (toolTitle == l10n.merge) {
      if (selectedFiles.length >= 2) {
        Navigator.pushNamed(context, '/merge', arguments: selectedFiles);
      } else {
        // _showErrorDialog(l10n.selectTwoFilesFirst(toolTitle));
      }
    } else if (toolTitle == l10n.split ||
        toolTitle == l10n.watermark ||
        toolTitle == l10n.repairPdf ||
        toolTitle == l10n.signPdf) {
      if (selectedFiles.length == 1) {
        Navigator.pushNamed(context, '/$toolTitle', arguments: selectedFiles);
      } else {
        // _showErrorDialog(l10n.selectOneFileFirst(toolTitle));
      }
    } else {
      Navigator.pushNamed(context, '/$toolTitle', arguments: selectedFiles);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  /*--------------------------------------------------
  | واجهة المستخدم                                    |
  --------------------------------------------------*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(context),
            if (isSearching) _buildSearchField(),
            Expanded(child: _buildToolsGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset('assets/images/Osp logo.png',
                width: 70, height: 40, fit: BoxFit.contain),
          ),
          Row(
            children: [
              InkWell(
                onTap: toggleSearchBar,
                child: Image.asset('assets/images/searchbutton.png',
                    width: 90, height: 80),
              ),
              InkWell(
                child: Image.asset('assets/images/menu.png',
                    width: 70, height: 70),
                onTap: () {
                  setState(() {
                    isListView = !isListView;
                  });
                },
              ),
              InkWell(
                child: Image.asset('assets/images/back.png',
                    width: 80, height: 80),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        onChanged: updateSearchQuery,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => updateSearchQuery(''),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildToolsGrid() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: isListView
          ? ListView.builder(
              itemCount: filteredTools.length,
              itemBuilder: (_, index) {
                final tool = filteredTools[index];
                return ListTile(
                  leading: tool.iconUrl.isNotEmpty
                      ? Image.asset('assets/images/${tool.iconUrl}',
                          width: 30, height: 30)
                      : null,
                  title: Text(tool.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FilePickerScreen(
                          selectedTool: tool.title,
                          folderPath: 'path/to/folder',
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 105 / 110,
              ),
              itemCount: filteredTools.length,
              itemBuilder: (_, index) {
                final tool = filteredTools[index];
                return PDFToolCard(
                  tool: tool,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FilePickerScreen(
                          selectedTool: tool.title,
                          folderPath: 'path/to/folder',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PDFTool {
  final String title;
  final String iconUrl;

  PDFTool({required this.title, required this.iconUrl});
}

class PDFToolCard extends StatelessWidget {
  final PDFTool tool;
  final VoidCallback onTap;

  const PDFToolCard({super.key, required this.tool, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? AppColor.darkmode : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF909090), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tool.iconUrl.isNotEmpty) ...[
              Image.asset('assets/images/${tool.iconUrl}',
                  width: 22, height: 22),
              const SizedBox(height: 8),
            ],
            Text(
              tool.title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
