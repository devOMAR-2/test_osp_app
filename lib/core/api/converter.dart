import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:osp/core/loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class CloudmersiveConverter {
  static const String _apiKey = 'c6c81363-16f2-42e8-841d-1100743ec94e';
  static final Dio _dio = Dio()..options.headers['Apikey'] = _apiKey;

  static Future<void> _saveAndOpenFile(List<int> bytes, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/$filename';
      final file = File(path);
      await file.writeAsBytes(bytes);
      await OpenFile.open(path);
    } catch (e) {
      debugPrint('Error saving or opening file: $e');
    }
  }

  static Future<T> _showLoadingWhile<T>(
      BuildContext context, Future<T> Function() task) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          Center(child: LoadingWidget(bgColor: Colors.transparent)),
    );
    try {
      return await task();
    } finally {
      Navigator.of(context).pop();
    }
  }

  static Future<void> _uploadSingleFileAndConvert({
    required BuildContext context,
    required String url,
    required String path,
    required String contentType,
    required String accept,
    required String outputName,
  }) async {
    await _showLoadingWhile(context, () async {
      try {
        final file = File(path);
        final response = await _dio.post(
          url,
          data: file.openRead(),
          options: Options(
            headers: {
              'Content-Type': contentType,
              'Accept': accept,
              'Apikey': _apiKey,
            },
            responseType: ResponseType.bytes,
          ),
        );
        await _saveAndOpenFile(response.data, outputName);
      } on DioException catch (e) {
        debugPrint('DioException: ${e.response?.statusCode} - ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في الاتصال بالخادم.')),
        );
      } catch (e) {
        debugPrint('Unhandled exception: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ غير متوقع.')),
        );
      }
    });
  }

  static Future<void> _uploadMultipleFilesAndConvert({
    required BuildContext context,
    required String url,
    required List<String> filePaths,
    required String accept,
    required String outputName,
  }) async {
    if (filePaths.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر حتى 10 ملفات فقط')),
      );
      return;
    }

    await _showLoadingWhile(context, () async {
      try {
        final formData = FormData();
        for (var path in filePaths) {
          final file = File(path);
          formData.files.add(MapEntry(
            'files',
            await MultipartFile.fromFile(file.path,
                filename: path.split('/').last),
          ));
        }

        final response = await _dio.post(
          url,
          data: formData,
          options: Options(
            headers: {
              'Accept': accept,
              'Apikey': _apiKey,
            },
            responseType: ResponseType.bytes,
          ),
        );

        await _saveAndOpenFile(response.data, outputName);
      } on DioException catch (e) {
        debugPrint('DioException: ${e.response?.statusCode} - ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في رفع الملفات أو المعالجة.')),
        );
      } catch (e) {
        debugPrint('Unhandled exception: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ غير متوقع.')),
        );
      }
    });
  }

  // === Converters ===

  static Future<void> convertWordToPdf(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/docx/to/pdf',
        path: filePath,
        contentType: 'application/octet-stream',
        accept: 'application/pdf',
        outputName: 'converted.pdf',
      );

  static Future<void> convertPdfToWord(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/pdf/to/docx',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/octet-stream',
        outputName: 'converted.docx',
      );

  static Future<void> convertPdfToPpt(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/pdf/to/pptx',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/octet-stream',
        outputName: 'converted.pptx',
      );

  static Future<void> convertPptToPdf(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/pptx/to/pdf',
        path: filePath,
        contentType: 'application/octet-stream',
        accept: 'application/pdf',
        outputName: 'converted.pdf',
      );

  static Future<void> convertExcelToPdf(
          BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/xlsx/to/pdf',
        path: filePath,
        contentType: 'application/octet-stream',
        accept: 'application/pdf',
        outputName: 'converted.pdf',
      );

  static Future<void> convertPdfToExcel(
          BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/pdf/to/xlsx',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/octet-stream',
        outputName: 'converted.xlsx',
      );

  static Future<void> convertPdfToJpg(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/pdf/to/jpg',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/octet-stream',
        outputName: 'converted.jpg',
      );

  static Future<void> convertPngToPdf(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/png/to/pdf',
        path: filePath,
        contentType: 'image/png',
        accept: 'application/pdf',
        outputName: 'converted.pdf',
      );

  static Future<void> convertHtmlToPdf(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/html/to/pdf',
        path: filePath,
        contentType: 'text/html',
        accept: 'application/pdf',
        outputName: 'converted.pdf',
      );

  static Future<void> compressPdf(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url:
            'https://api.cloudmersive.com/convert/edit/pdf/optimize/reduce-file-size',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/pdf',
        outputName: 'compressed.pdf',
      );

  static Future<void> compressSingleFileToZip(
    BuildContext context,
    String filePath,
  ) async {
    final formData = FormData();

    // إضافة الملف الذي تريد ضغطه
    final file = File(filePath);
    formData.files.add(MapEntry(
      'files', // المفتاح الذي يتطلبه الـ API
      await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    ));

    await _showLoadingWhile(context, () async {
      try {
        final response = await _dio.post(
          'https://api.cloudmersive.com/convert/archive/zip/create', // API لتحويل الملف إلى ZIP
          data: formData,
          options: Options(
            headers: {'Apikey': _apiKey},
            responseType: ResponseType.bytes,
          ),
        );

        // حفظ وفتح الملف الناتج (ZIP)
        await _saveAndOpenFile(response.data, 'compressed_file.zip');
      } on DioException catch (e) {
        debugPrint('DioException: ${e.response?.statusCode} - ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في رفع الملف أو المعالجة.')),
        );
      } catch (e) {
        debugPrint('Unhandled exception: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ غير متوقع.')),
        );
      }
    });
  }

// end of compress processes

// split processes
  static Future<void> splitPdf(BuildContext context, String filePath) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/split/pdf',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/zip',
        outputName: 'split_pages.zip',
      );

// 1) استخراج كل صفحة في ملف PDF منفصل (كل صفحة ➜ ملف PDF)
  static Future<void> extractPagesToSeparatePdfs(
    BuildContext context,
    String filePath,
  ) =>
      _uploadSingleFileAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/split/pdf',
        // نفس endpoint الذي يعيد ZIP بداخله ملفات PDF مفردة لكل صفحة
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/zip',
        outputName: 'pages_separated.zip',
      );

  // 2) حذف صفحة (أو صفحات) معيّنة من ملف PDF
//    تمرّر أرقام الصفحات كمصفوفة وتحولها إلى استعلام query ?pages=1,3,5
  // static Future<void> deletePdfPages(
  //   BuildContext context,
  //   String filePath,
  //   List<int> pages,
  // ) {
  //   final pagesParam = pages.join(',');
  //   return _uploadSingleFileAndConvert(
  //     context: context,
  //     url:
  //         'https://api.cloudmersive.com/convert/pdf/delete-pages?pages=$pagesParam',
  //     path: filePath,
  //     contentType: 'application/pdf',
  //     accept: 'application/pdf',
  //     outputName: 'deleted_pages.pdf',
  //   );
  // }

  static Future<void> deletePdfPages(
    BuildContext context,
    String filePath,
    List<int> pages,
  ) async {
    final pagesParam = pages.join(',');

    return _uploadSingleFileAndConvert(
      context: context,
      url:
          'https://api.cloudmersive.com/convert/pdf/delete-pages?pages=$pagesParam',
      path: filePath,
      contentType: 'application/pdf',
      accept: 'application/pdf',
      outputName: 'deleted_pages.pdf',
    );
  }

//------------------------------------------------------------------
// 3) تقسيم باستخدام النطاق (range) – مثال: من الصفحة 5 إلى 10
  static Future<void> splitPdfByRange(
    BuildContext context,
    String filePath, {
    required int from,
    required int to,
  }) =>
      _uploadSingleFileAndConvert(
        context: context,
        url:
            'https://api.cloudmersive.com/convert/split/pdf/by-range?from=$from&to=$to',
        path: filePath,
        contentType: 'application/pdf',
        accept: 'application/pdf',
        outputName: 'range_${from}_$to.pdf',
      );
//end of split processes

  static Future<void> mergeSelectedPdfs(
          BuildContext context, List<String> filePaths) =>
      _uploadMultipleFilesAndConvert(
        context: context,
        url: 'https://api.cloudmersive.com/convert/merge/pdf/multi',
        filePaths: filePaths,
        accept: 'application/pdf',
        outputName: 'merged.pdf',
      );

  static Future<void> addWatermarkToPdf({
    required BuildContext context,
    required String filePath,
    required String watermarkText,
    String? fontName,
    double? fontSize,
    String? fontColor,
    double? fontTransparency,
  }) async {
    await _showLoadingWhile(context, () async {
      try {
        final file = File(filePath);

        final headers = {
          'Apikey': _apiKey,
          'watermarkText': watermarkText,
          if (fontName != null) 'fontName': fontName,
          if (fontSize != null) 'fontSize': fontSize.toString(),
          if (fontColor != null) 'fontColor': fontColor,
          if (fontTransparency != null)
            'fontTransparency': fontTransparency.toString(),
        };

        final formData = FormData.fromMap({
          'inputFile': await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last),
        });

        final response = await _dio.post(
          'https://api.cloudmersive.com/convert/edit/pdf/watermark/text',
          data: formData,
          options: Options(
            headers: headers,
            responseType: ResponseType.bytes,
          ),
        );

        await _saveAndOpenFile(response.data, 'watermarked.pdf');
      } on DioException catch (e) {
        debugPrint('DioException: ${e.response?.statusCode} - ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في إضافة العلامة المائية.')),
        );
      } catch (e) {
        debugPrint('Unhandled exception: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ غير متوقع.')),
        );
      }
    });
  }
}
