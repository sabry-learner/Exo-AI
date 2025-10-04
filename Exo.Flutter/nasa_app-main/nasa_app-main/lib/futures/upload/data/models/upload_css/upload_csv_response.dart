import 'dart:convert';

class UploadCsvFileResponse {
  final String status;
  final String message;
  final List<String> filesReceived;

  UploadCsvFileResponse({
    required this.status,
    required this.message,
    required this.filesReceived,
  });

  factory UploadCsvFileResponse.fromJson(Map<String, dynamic> json) {
    return UploadCsvFileResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      filesReceived: List<String>.from(json['files_received'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "files_received": filesReceived,
    };
  }

  /// Parse raw JSON string
  factory UploadCsvFileResponse.fromRawJson(String str) =>
      UploadCsvFileResponse.fromJson(json.decode(str));

  /// Convert to raw JSON string
  String toRawJson() => json.encode(toJson());
}
