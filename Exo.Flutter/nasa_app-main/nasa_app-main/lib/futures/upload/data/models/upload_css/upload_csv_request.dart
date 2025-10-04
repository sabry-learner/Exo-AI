import 'package:dio/dio.dart';

class UploadCsvFileRequest {
  final String filePath; // مكان الملف CSV
  final String fileName; // اسم الملف
  final bool useCV; // هل يستخدم cross validation ؟

  UploadCsvFileRequest({
    required this.filePath,
    required this.fileName,
    this.useCV = true,
  });

  /// تحويل الـ Data لـ FormData عشان نقدر نرفعه بالـ Dio
  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'use_cv': useCV.toString(),
    });
  }
}
