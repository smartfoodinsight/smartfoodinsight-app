import 'package:image_picker/image_picker.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class CameraGalleryService extends ICameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhotoAsync() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (photo == null) return null;

    return photo.path;
  }

  @override
  Future<String?> takePhotoAsync() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear);

    if (photo == null) return null;

    return photo.path;
  }
}
