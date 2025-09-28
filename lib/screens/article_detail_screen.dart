import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/article.dart';
import '../utils/theme.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.milestoneNavy,
            flexibleSpace: FlexibleSpaceBar(
              background: article.featuredImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: article.featuredImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppTheme.milestoneNavy,
                        child: const Icon(
                          Icons.article,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        gradient: AppTheme.milestoneGradient,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.article,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.milestoneBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      article.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.milestoneBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.milestoneNavy,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.milestoneBlue.withOpacity(0.1),
                        child: Text(
                          article.author.isNotEmpty ? article.author[0].toUpperCase() : 'A',
                          style: const TextStyle(
                            color: AppTheme.milestoneBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.author,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.milestoneNavy,
                              ),
                            ),
                            Text(
                              _formatDate(article.createdAt),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Share functionality
                        },
                        icon: const Icon(
                          Icons.share,
                          color: AppTheme.milestoneBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  if (article.excerpt.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.milestoneBlue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.milestoneBlue.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        article.excerpt,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: AppTheme.milestoneNavy,
                          height: 1.5,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  
                  Html(
                    data: article.content,
                    style: {
                      "body": Style(
                        fontSize: FontSize(16),
                        lineHeight: const LineHeight(1.6),
                        color: AppTheme.milestoneNavy,
                      ),
                      "h1": Style(
                        fontSize: FontSize(24),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.milestoneNavy,
                        margin: Margins.only(top: 20, bottom: 10),
                      ),
                      "h2": Style(
                        fontSize: FontSize(20),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.milestoneBlue,
                        margin: Margins.only(top: 16, bottom: 8),
                      ),
                      "p": Style(
                        margin: Margins.only(bottom: 12),
                      ),
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  const Text(
                    'Related Articles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.milestoneNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Related articles will appear here',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
