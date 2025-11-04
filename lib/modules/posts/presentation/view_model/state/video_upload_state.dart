class VideoUploadState {
  final double progress;
  final bool isUploading;
  final String? filePath;
  final String? error;

  const VideoUploadState({
    this.progress = 0,
    this.isUploading = false,
    this.filePath,
    this.error,
  });

  VideoUploadState copyWith({
    double? progress,
    bool? isUploading,
    String? filePath,
    String? error,
  }) {
    return VideoUploadState(
      progress: progress ?? this.progress,
      isUploading: isUploading ?? this.isUploading,
      filePath: filePath ?? this.filePath,
      error: error ?? this.error,
    );
  }
}
