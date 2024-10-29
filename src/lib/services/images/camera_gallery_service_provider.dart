import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/services/services.dart';

part 'camera_gallery_service_provider.g.dart';

@riverpod
CameraGalleryService cameraGalleryService(Ref ref) {
  return CameraGalleryService();
}
