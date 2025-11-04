abstract class UploadEvent {
  final String productId;
  UploadEvent(this.productId);

  factory UploadEvent.progress({
    required String productId,
    required double progress,
  }) = UploadProgress;

  factory UploadEvent.success({
    required String productId,
    required List<String> imageUrls,
    required int storeId,
  }) = UploadSuccess;

  factory UploadEvent.error({
    required String productId,
    required String error,
  }) = UploadError;
}

class UploadProgress extends UploadEvent {
  final double progress;
  UploadProgress({required String productId, required this.progress})
    : super(productId);
}

class UploadSuccess extends UploadEvent {
  final List<String> imageUrls;
  final int storeId;
  UploadSuccess({
    required String productId,
    required this.imageUrls,
    required this.storeId,
  }) : super(productId);
}

class UploadError extends UploadEvent {
  final String error;
  UploadError({required String productId, required this.error})
    : super(productId);
}

class PendingUpload {
  final String productId;
  final List<String> imagePaths;
  final int storeId;
  int retryCount;

  PendingUpload({
    required this.productId,
    required this.imagePaths,
    this.retryCount = 0,
    this.storeId = 0,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'imagePaths': imagePaths,
   'retryCount': retryCount,
   'storeId': storeId,
  };

  factory PendingUpload.fromJson(Map<String, dynamic> json) => PendingUpload(
    productId: json['productId'],
    imagePaths: List<String>.from(json['imagePaths']),
    retryCount: json['retryCount'] ?? 0,
    storeId: json['storeId'] ?? 0,
  );
}
