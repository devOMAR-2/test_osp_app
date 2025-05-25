import 'dart:io';
import 'package:flutter/material.dart';
import '../../../widgets/customappbar.dart'; // استيراد شريط التنقل المخصص
import '../../../../auth/widgets/custom_button.dart'; // استيراد CustomButton

class FixedRange extends StatefulWidget {
  final File file;

  const FixedRange({super.key, required this.file});

  @override
  State<FixedRange> createState() => _FixedRangeState();
}

class _FixedRangeState extends State<FixedRange> {
  int? fixedRangeValue;

  void _showRangeInputDialog() {
    final TextEditingController rangeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text("الفترة"),
          content: TextField(
            controller: rangeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                child: const Text("حسناً"),
                onPressed: () {
                  final value = int.tryParse(rangeController.text);
                  if (value != null && value > 0) {
                    setState(() {
                      fixedRangeValue = value;
                    });
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('يرجى إدخال رقم صحيح أكبر من صفر')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _splitPdf() {
    if (fixedRangeValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تحديد النطاق الثابت أولاً')),
      );
      return;
    }

    print('سيتم تقسيم الملف إلى أجزاء كل $fixedRangeValue صفحات');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تقسيم بنطاق ثابت',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _showRangeInputDialog,
                  child: Align(
                    alignment:
                        Alignment.centerRight, // محاذاة النص إلى الجهة اليمنى
                    child: const Text(
                      ": تقسيم المستند إلى صفحات متساوية ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xD78852A8),
                      ),
                      textAlign:
                          TextAlign.right, // محاذاة النص داخل العنصر نفسه
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment:
                      Alignment.centerRight, // محاذاة الرقم إلى الجهة اليمنى
                  child: Text(
                    fixedRangeValue != null ? '$fixedRangeValue' : '1',
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xD78852A8)),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomButton(
                width: 180,
                height: 50,
                text: 'تقسيم',
                onPressed: _splitPdf,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
