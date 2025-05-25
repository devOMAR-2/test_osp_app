import 'package:flutter/material.dart';
import 'tools/widgets/file_picker.dart';
import 'auth/widgets/custom_button.dart';
import 'tools/widgets/customappbar.dart'; // تأكد من وجود هذا الملف

class FoldersScreen extends StatefulWidget {
  final String selectedTool;

  const FoldersScreen({super.key, required this.selectedTool});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  List<dynamic> selectedFiles = [];
  bool isBottomSheetExpanded = false;

  void toggleBottomSheet() {
    setState(() {
      isBottomSheetExpanded = !isBottomSheetExpanded;
    });
  }

  bool isSelectionValid() {
    return selectedFiles.isNotEmpty;
  }

  void navigateToToolPage() {
    // قم بتنفيذ التنقل المناسب حسب الأداة المختارة
  }

  void _navigateToFilePicker(
      BuildContext context, String selectedFolder) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilePickerScreen(
          selectedTool: widget.selectedTool,
          folderPath: selectedFolder,
        ),
      ),
    );

    if (result != null && result is List) {
      setState(() {
        selectedFiles = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ شريط التنقل العلوي باستخدام CustomAppBar
            CustomAppBar(
              title: 'الملفات',
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10),

            // ✅ قائمة المجلدات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  return GestureDetector(
                    onTap: () {
                      _navigateToFilePicker(context, folder.name);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                folder.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xCC8852A8), // تعديل اللون
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                folder.date,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0x808852A8), // تعديل اللون
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/folder.png',
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // ✅ Bottom Sheet محاذى لليمين
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isBottomSheetExpanded ? 250 : 110,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: toggleBottomSheet,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'تم تحديد ${selectedFiles.length} ${selectedFiles.length == 1 ? 'ملف' : 'ملفات'}',
                            style: const TextStyle(color: Colors.purple),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            isBottomSheetExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.purple,
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
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                                      color: Color(0xFF8852A8), // تعديل اللون
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.right,
                                  )),
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
                      text: 'التالي',
                      onPressed: isSelectionValid() ? navigateToToolPage : null,
                      color: isSelectionValid()
                          ? Colors.purple
                          : Colors.grey.shade300,
                      textColor:
                          isSelectionValid() ? Colors.white : Colors.grey,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Folder {
  final String name;
  final String path;
  final String date;

  Folder({
    required this.name,
    required this.path,
    required this.date,
  });
}

final List<Folder> folders = [
  Folder(name: 'التخزين الداخلي', path: '/internal', date: '2025-04-13'),
  Folder(name: 'التحميلات', path: '/downloads', date: '2025-04-12'),
  Folder(name: 'الملفات المعالجة', path: '/processed', date: '2025-04-11'),
];
