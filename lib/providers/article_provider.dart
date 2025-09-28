import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article.dart';

class ArticleProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('articles')
          .orderBy('createdAt', descending: true)
          .get();

      _articles = snapshot.docs
          .map((doc) => Article.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching articles: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addArticle(Article article) async {
    try {
      await _firestore.collection('articles').add(article.toMap());
      await fetchArticles();
    } catch (e) {
      print('Error adding article: $e');
    }
  }

  Future<void> updateArticle(String id, Article article) async {
    try {
      await _firestore.collection('articles').doc(id).update(article.toMap());
      await fetchArticles();
    } catch (e) {
      print('Error updating article: $e');
    }
  }

  Future<void> deleteArticle(String id) async {
    try {
      await _firestore.collection('articles').doc(id).delete();
      await fetchArticles();
    } catch (e) {
      print('Error deleting article: $e');
    }
  }
}
