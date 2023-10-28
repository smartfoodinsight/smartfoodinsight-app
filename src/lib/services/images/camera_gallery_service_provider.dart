import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/services/services.dart';

part 'camera_gallery_service_provider.g.dart';

@riverpod
CameraGalleryService cameraGalleryService(CameraGalleryServiceRef ref) {
  return CameraGalleryService();
}
