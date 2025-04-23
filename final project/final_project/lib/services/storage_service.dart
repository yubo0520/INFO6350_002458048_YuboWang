
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'auth_service.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AuthService _authService = AuthService();
  final Uuid _uuid = Uuid();

  // upload image to firebase storage and return download url
  Future<String> uploadImage(File image) async {
    try {
      // generate unique filename
      final String uniqueId = _uuid.v4();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = '.jpg';
      
      // get current user id
      final userId = _authService.getCurrentUser()?.uid ?? 'anonymous';
      
      // create storage reference with path
      final storageRef = _storage.ref().child('posts/$userId/${uniqueId}_$timestamp$extension');
      
      // upload with metadata
      final uploadTask = storageRef.putFile(
        image,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'userId': userId, 'created': timestamp},
        ),
      );
      
      // wait for upload to complete
      final snapshot = await uploadTask;
      
      // get and return download url
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // delete image from storage by its url
  Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}