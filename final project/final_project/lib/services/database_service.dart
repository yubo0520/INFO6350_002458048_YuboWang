import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create a new post in firestore
  Future<void> createPost(Post post) async {
    try {
      await _firestore.collection('posts').add(post.toMap());
    } catch (e) {
      // proper error handling instead of print statements
      throw Exception('Failed to create post: $e');
    }
  }

  // get stream of all posts ordered by creation date
  Stream<List<Post>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            return snapshot.docs
                .map((doc) => Post.fromMap(doc.data(), doc.id))
                .toList();
          } catch (e) {
            // log error but return empty list to prevent UI crashes
            print('Error parsing posts: $e');
            return <Post>[];
          }
        });
  }

  // get stream of posts filtered by user id
  Stream<List<Post>> getPostsByUser(String userId) {
    return _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            return snapshot.docs
                .map((doc) => Post.fromMap(doc.data(), doc.id))
                .toList();
          } catch (e) {
            // log error but return empty list to prevent UI crashes
            print('Error parsing user posts: $e');
            return <Post>[];
          }
        });
  }

  // fetch a single post by its id
  Future<Post?> getPostById(String postId) async {
    try {
      final doc = await _firestore.collection('posts').doc(postId).get();
      if (doc.exists && doc.data() != null) {
        return Post.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get post: $e');
    }
  }

  // update an existing post
  Future<void> updatePost(Post post) async {
    try {
      if (post.id == null) {
        throw Exception('Post ID is required for updates');
      }
      await _firestore.collection('posts').doc(post.id).update(post.toMap());
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // delete a post by its id
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}