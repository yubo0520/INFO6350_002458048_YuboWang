import 'package:image_picker/image_picker.dart';

// helper class for image picking and processing
class ImageHelper {
  final ImagePicker _picker = ImagePicker();

  // pick an image from camera or gallery
  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // compress image to reduce size
      );
      
      return pickedFile;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
  
  Future<XFile?> cropImage(XFile file) async {
    return file;
  }
}