import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/upload/data/models/upload_css/upload_csv_request.dart';
import 'package:nasa_app/futures/upload/presentation/managers/upload_csv_cubit/upload_csv_cubit.dart';

class CsvUploadWidget extends StatelessWidget {
  const CsvUploadWidget({super.key});

  void _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'tsv'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        final request = UploadCsvFileRequest(
          filePath: file.path!,
          fileName: file.name,
        );

        // لازم تبعت للـ Cubit
        context.read<UploadCsvCubit>().uploadCsv(request);
      } else {
        print('File selection cancelled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color containerBackgroundColor = const Color(0xFF191632);
    final Color borderColor = const Color(0xFF5F6184);

    return Container(
      width: 400.w,
      height: 500.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2.r,
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 6],
          strokeWidth: 3,
          color: borderColor,
          radius: Radius.circular(12.r),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<UploadCsvCubit, UploadCsvState>(
                builder: (context, state) {
                  if (state is UploadCsvFilePicked) {
                    return Column(
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          size: 40.sp,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          state.fileName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "File ready to upload ✅",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    );
                  } else if (state is UploadCsvLoading) {
                    return Column(
                      children: [
                        CircularProgressIndicator(color: Colors.blueAccent),
                        SizedBox(height: 10.h),
                        Text(
                          "Uploading...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else if (state is UploadCsvSuccess) {
                    return Text(
                      "Upload Successful 🎉",
                      style: TextStyle(color: Colors.greenAccent),
                    );
                  } else if (state is UploadCsvFailure) {
                    return Text(
                      "Error: ${state.message}",
                      style: TextStyle(color: Colors.redAccent),
                    );
                  }
                  // الحالة العادية
                  return Column(
                    children: [
                      Container(
                        width: 70.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: borderColor.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.cloud_upload_outlined,
                          size: 40.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Drag & drop your CSV files here',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'or click to browse files',
                        style: TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 25.h),
              GestureDetector(
                onTap: () {
                  _pickFile(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      colors: [Color(0xFF6A5ACD), Color(0xFFA052CD)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Text(
                    'Select Files',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'Supports: CSV, TSV (Max 100MB per file)',
                style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
