enum UploadStatus { completed, processing, failed }

class UploadItem {

  final String fileName;
  final String timeAgo;
  final int objectsCount;
  final UploadStatus status;

  UploadItem({
    required this.fileName,
    required this.timeAgo,
    required this.objectsCount,
    required this.status,
  });
}