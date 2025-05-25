import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osp/core/api/converter.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';

import 'package:osp/features/tools/tools/standard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../auth/widgets/custom_button.dart';
import 'filelist.dart';
import '../tools/merge/merge.dart';
import '../tools/watermark.dart';
import '../../repair.dart';
import '../../sign.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'split.dart'; // تأكد أنك ضايف صفحة التقسيم

class FilePickerScreen extends StatefulWidget {
  final String selectedTool;
  final String folderPath;

  const FilePickerScreen({
    super.key,
    required this.selectedTool,
    required this.folderPath,
  });

  @override
  State<FilePickerScreen> createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  bool isBottomSheetExpanded = false;
  List<File> selectedFiles = [];
  // List<String> folders = ['التخزين الداخلي', 'التحميلات', 'المعالجة'];

  void toggleBottomSheet() {
    setState(() => isBottomSheetExpanded = !isBottomSheetExpanded);
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      } else {
        var result = await Permission.manageExternalStorage.request();
        return result.isGranted;
      }
    } else {
      var status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  Future<List<FileSystemEntity>> getFilesFromFolder(String folderType) async {
    bool granted = await requestStoragePermission();
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.permissionDenied,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      openAppSettings();
      return [];
    }

    Directory? directory;
    switch (folderType) {
      case 'التخزين الداخلي' || 'Internal Storage':
        directory = Directory('/storage/emulated/0/');
        break;
      case 'التحميلات' || 'Downloads':
        directory = Directory('/storage/emulated/0/Download');
        break;
      case 'المعالجة' || 'Processing':
        directory = Directory('/storage/emulated/0/OSPProcessing');
        break;
    }

    if (directory != null && await directory.exists()) {
      List<FileSystemEntity> files = directory.listSync();
      if (files.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.folderNotFound,
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.purple,
          ),
        );
      }
      return files;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noFiles,
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple,
        ),
      );
      return [];
    }
  }

  void openFolder(String folderType) async {
    List<FileSystemEntity> files = await getFilesFromFolder(folderType);
    if (files.isNotEmpty) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(folderType);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FilesListScreen(
            files: files,
            folderName: folderType,
            selectedFiles: selectedFiles,
            selectedTool: widget.selectedTool,
            onFileSelected: (fileEntity, isSelected) {
              final fileObj = File(fileEntity.path);
              setState(() {
                if (isSelected &&
                    !selectedFiles.any((f) => f.path == fileObj.path)) {
                  selectedFiles.add(fileObj);
                } else if (!isSelected) {
                  selectedFiles.removeWhere((f) => f.path == fileObj.path);
                }
              });
            },
          ),
        ),
      );
    }
  }

  bool isSelectionValid() {
    final count = selectedFiles.length;
    final tool = widget.selectedTool;
    if (tool == 'دمج' || tool == 'Merge') return count > 1;
    return count >= 1;
  }

  void goToToolPage() {
    final tool = widget.selectedTool;

    if (!isSelectionValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          AppLocalizations.of(context)!.selectMoreFiles,
        )),
      );
      return;
    }

    Widget destination;
    switch (tool) {
      case 'دمج' || 'Merge':
        print("الملفات قبل الإرسال: ${selectedFiles.length}");
        for (var f in selectedFiles) {
          print("ملف: ${f.path}");
        }

        destination = MergePdf(
          selectedFiles: selectedFiles.map((file) => file.path).toList(),
        );

        break;
      case 'تقسيم':
        destination = WatermarkScreen(selectedFiles: selectedFiles);
        break;
      case 'العلامة المائية':
        destination = WatermarkScreen(selectedFiles: selectedFiles);
        break;
      case 'اصلاح مستند':
        destination = DocumentRepairScreen(selectedFiles: selectedFiles);
        break;
      case 'توقيع مستند':
        destination = DocumentSignScreen(selectedFiles: selectedFiles);
        break;
      case 'PDF إلى Word':
        destination = Standard(
          name: 'PDF إلى Word',
          selectedFiles: selectedFiles,
          func: () {
            CloudmersiveConverter.convertPdfToWord(
              context,
              selectedFiles.first.path,
            );
          },
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            AppLocalizations.of(context)!.unsupportedTool,
          )),
        );
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final loc = AppLocalizations.of(context)!;
    List<String> folders = [
      loc.internalStorage, // "Internal Storage" أو "التخزين الداخلي"
      loc.downloads, // "Downloads" أو "التحميلات"
      loc.processing, // "Processing" أو "المعالجة"
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(AppLocalizations.of(context)!.files,
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
                    // const SizedBox(height: 20),
                    ...folders.map((folder) {
                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: GestureDetector(
                          onTap: () => openFolder(folder),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(folder,
                                        style: const TextStyle(
                                            color: Colors.purple,
                                            fontSize: 18)),
                                    const Text('28/11/2023, 12:52:22 م',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Image.asset('assets/images/folder.png',
                                    width: 60, height: 60),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isBottomSheetExpanded ? 250 : 110,
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
                              '${AppLocalizations.of(context)!.selected} ${selectedFiles.length} ${selectedFiles.length == 1 ? AppLocalizations.of(context)!.files : AppLocalizations.of(context)!.files}',
                              style: const TextStyle(color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: selectedFiles.length,
                          itemBuilder: (context, index) {
                            final file = selectedFiles[index];
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
                                          selectedFiles.removeAt(index);
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
                      CustomButton(
                        width: double.infinity,
                        height: 50,
                        text: AppLocalizations.of(context)!.next,
                        onPressed: goToToolPage,
                        color: Colors.purple,
                        textColor: Colors.white,
                      ),
                    ],
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
