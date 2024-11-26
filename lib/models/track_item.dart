import 'package:dio/dio.dart';

class TrackItem {
  String id;
  String type;
  String title;
  List<String> pathLs = [];
  bool selected = false;
  int depth = 0;

  TrackItem({
    required this.id,
    required this.type,
    required this.title,
  });

  TrackItem copyWith({
    String? id,
    String? type,
    String? title,
    List<String>? pathLs,
    bool? selected,
    int? depth,
  }) {
    return TrackItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    )
      ..pathLs = pathLs ?? List<String>.of(this.pathLs)
      ..selected = selected ?? this.selected
      ..depth = depth ?? this.depth;
  }
}

class Folder extends TrackItem {
  List<TrackItem> children = [];

  Folder({
    required super.id,
    super.type = 'folder',
    required super.title,
  });

  @override
  Folder copyWith({
    String? id,
    String? type,
    String? title,
    List<String>? pathLs,
    bool? selected,
    int? depth,
    List<TrackItem>? children,
  }) {
    return Folder(
      id: id ?? this.id,
      title: title ?? this.title,
    )
      ..pathLs = pathLs ?? List<String>.of(this.pathLs)
      ..selected = selected ?? this.selected
      ..depth = depth ?? this.depth
      ..children =
          children ?? this.children.map((child) => child.copyWith()).toList();
  }

  void setSelection(bool value) {
    selected = value;
    for (final child in children) {
      if (child is Folder) {
        child.setSelection(value);
      } else {
        child.selected = value;
      }
    }
  }

  TrackItem? search(String id) {
    for (final child in children) {
      if (child.id == id) {
        return child;
      }
      if (child is Folder) {
        final result = child.search(id);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }
}

enum DownloadStatus { notStarted, downloading, completed, failed, canceled }

class FileAsset extends TrackItem {
  String mediaStreamUrl;
  String mediaDownloadUrl;
  int size;

  String savePath;
  DownloadStatus status;
  double progress;
  CancelToken cancelToken;

  FileAsset({
    required super.id,
    required super.type,
    required super.title,
    required this.mediaStreamUrl,
    required this.mediaDownloadUrl,
    required this.size,
    this.savePath = '',
    this.status = DownloadStatus.notStarted,
    this.progress = 0.0,
    CancelToken? cancelToken,
  }) : cancelToken = cancelToken ?? CancelToken();

  @override
  FileAsset copyWith({
    String? id,
    String? type,
    String? title,
    List<String>? pathLs,
    bool? selected,
    int? depth,
    String? mediaStreamUrl,
    String? mediaDownloadUrl,
    int? size,
    String? savePath,
    DownloadStatus? status,
    double? progress,
    CancelToken? cancelToken,
  }) {
    return FileAsset(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      mediaStreamUrl: mediaStreamUrl ?? this.mediaStreamUrl,
      mediaDownloadUrl: mediaDownloadUrl ?? this.mediaDownloadUrl,
      size: size ?? this.size,
      savePath: savePath ?? this.savePath,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      cancelToken: cancelToken ?? CancelToken(),
    )
      ..pathLs = pathLs ?? List<String>.of(this.pathLs)
      ..selected = selected ?? this.selected
      ..depth = depth ?? this.depth;
  }
}
