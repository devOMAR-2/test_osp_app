import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/Osp logo.png',
                    width: 90,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  //    InkWell(
                  //   child: Image.asset(
                  //     'assets/images/searchbutton.png',
                  //     width: 90,
                  //     height: 90,
                  //     fit: BoxFit.contain,
                  //   ),
                  //   onTap: () {
                  //     toggleSearchBar();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSectionTitle('تنظيم ملف PDF'),
                  _buildListItem('دمج ملفات PDF', 'assets/images/merge.png'),
                  _buildListItem('تقسيم PDF', 'assets/images/split.png'),
                  _buildListItem(
                      'إعادة ترتيب صفحات PDF', 'assets/images/orgnize.png'),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('تحسين جودة ملف PDF'),
                  _buildListItem('ضغط PDF', 'assets/images/compress.png'),
                  _buildListItem('إصلاح ملف PDF', 'assets/images/fix.png'),
                  _buildListItem(
                      'قابل للبحث PDF', 'assets/images/searchable.png'),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('التحويل إلى PDF'),
                  _buildListItem('صورة إلى PDF', 'assets/images/pic2pdf.png'),
                  _buildListItem('Word to PDF', 'assets/images/w2pdf.png'),
                  _buildListItem(
                      'PowerPoint to PDF', 'assets/images/P2pdf.png'),
                  _buildListItem('Excel to PDF', 'assets/images/E2pdf.png'),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('التحويل من PDF'),
                  _buildListItem('PDF to JPG', 'assets/images/pdf_2jpg.png'),
                  _buildListItem('PDF إلى Word', 'assets/images/pdf2w.png'),
                  _buildListItem(
                      'PDF to PowerPoint', 'assets/images/pdf2P.png'),
                  _buildListItem('PDF 2 Excel', 'assets/images/pdf2xcel.png'),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('تعديل ملف PDF'),
                  _buildListItem('تدوير ملفات PDF', 'assets/images/rotate.png'),
                  _buildListItem(
                      'ترقيم الصفحات', 'assets/images/page-numbering.png'),
                  _buildListItem(
                      'العلامة المائية', 'assets/images/watermark.png'),
                  _buildListItem('تعديل ملف PDF', 'assets/images/edit.png'),
                  _buildListItem('إنشاء ملف PDF', 'assets/images/create.png'),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('أدوات حماية وفتح ملفات PDF'),
                  _buildListItem(
                      'فتح قفل ملفات PDF', 'assets/images/unlock.png'),
                  _buildListItem('حماية ملف PDF', 'assets/images/protect.png'),
                  _buildListItem('توقيع مستند PDF', 'assets/images/sign.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildListItem(String text, String assetImage) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Image.asset(
            assetImage,
            width: 22,
            height: 22,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF4B0082).withOpacity(0.3),
          width: 1,
        ),
      ),
    );
  }
}
