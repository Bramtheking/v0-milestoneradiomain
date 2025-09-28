import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String? id;
  final String title;
  final String author;
  final String category;
  final String featuredImage;
  final String excerpt;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.featuredImage,
    required this.excerpt,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Article(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      category: data['category'] ?? '',
      featuredImage: data['featuredImage'] ?? '',
      excerpt: data['excerpt'] ?? '',
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'category': category,
      'featuredImage': featuredImage,
      'excerpt': excerpt,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
