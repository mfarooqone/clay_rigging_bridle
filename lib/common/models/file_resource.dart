class FileResource {
  String? status;
  String? message;
  List<Files>? files;
  List<String>? errors;

  FileResource({this.status, this.message, this.files, this.errors});

  FileResource.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    errors = json['errors'].cast<String>();
  }
}

class Files {
  int? fileId;
  String? fileName;
  String? fileType;
  int? fileSize;

  Files({this.fileId, this.fileName, this.fileType, this.fileSize});

  Files.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileSize = json['file_size'];
  }
}
