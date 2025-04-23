import 'package:cloud_firestore/cloud_firestore.dart';

// post model representing garage sale item
class Post {
  final String? id; 
  final String userId; 
  final String title; 
  final double price; 
  final String description; 
  final List<String> imageUrls; 
  final DateTime createdAt; 

  Post({
    this.id,
    required this.userId,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrls,
    required this.createdAt,
  });

  // create post object from firestore document
  factory Post.fromMap(Map<String, dynamic> data, String id) {
    return Post(
      id: id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] is Timestamp 
              ? (data['createdAt'] as Timestamp).toDate()
              : DateTime.parse(data['createdAt'].toString()))
          : DateTime.now(),
    );
  }

  // convert post to map for firestore storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'price': price,
      'description': description,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
