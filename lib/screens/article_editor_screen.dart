import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article.dart';
import '../providers/article_provider.dart';
import '../utils/theme.dart';

class ArticleEditorScreen extends StatefulWidget {
  final Article? article;

  const ArticleEditorScreen({
    super.key,
    this.article,
  });

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _excerptController = TextEditingController();
  final _contentController = TextEditingController();
  
  String _selectedCategory = 'Education';
  String _featuredImageUrl = '';
  bool _isLoading = false;
  bool _isUploadingImage = false;

  final List<String> _categories = ['Education', 'Community', 'News', 'Events'];

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      _titleController.text = widget.article!.title;
      _authorController.text = widget.article!.author;
      _excerptController.text = widget.article!.excerpt;
      _contentController.text = widget.article!.content;
      _selectedCategory = widget.article!.category;
      _featuredImageUrl = widget.article!.featuredImage;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _excerptController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article == null ? 'New Article' : 'Edit Article'),
        backgroundColor: AppTheme.milestoneNavy,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveArticle,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Featured Image',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.milestoneNavy,
                ),
              ),
              const SizedBox(height: 10),
              
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: _isUploadingImage
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.milestoneBlue),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Uploading image...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : _featuredImageUrl.isNotEmpty
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _featuredImageUrl,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: _pickImage,
                                      icon: const Icon(Icons.edit),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppTheme.milestoneBlue,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _featuredImageUrl = '';
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppTheme.milestoneRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: _pickImage,
                            borderRadius: BorderRadius.circular(12),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Tap to add featured image',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
              const SizedBox(height: 30),
              
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Article Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.milestoneBlue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter article title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _authorController,
                      decoration: InputDecoration(
                        labelText: 'Author',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.milestoneBlue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter author name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.milestoneBlue),
                        ),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _excerptController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Article Excerpt',
                  hintText: 'Brief summary of the article...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.milestoneBlue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter article excerpt';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _contentController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Article Content',
                  hintText: 'Write your article content here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.milestoneBlue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter article content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );
    
    if (image != null) {
      setState(() {
        _isUploadingImage = true;
      });

      try {
        final uploadedUrl = await _uploadToCloudinary(File(image.path));
        if (uploadedUrl != null) {
          setState(() {
            _featuredImageUrl = uploadedUrl;
            _isUploadingImage = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image uploaded successfully!'),
                backgroundColor: AppTheme.milestoneBlue,
              ),
            );
          }
        } else {
          setState(() {
            _isUploadingImage = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to upload image. Please try again.'),
                backgroundColor: AppTheme.milestoneRed,
              ),
            );
          }
        }
      } catch (e) {
        setState(() {
          _isUploadingImage = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error uploading image: ${e.toString()}'),
              backgroundColor: AppTheme.milestoneRed,
            ),
          );
        }
      }
    }
  }

  Future<String?> _uploadToCloudinary(File imageFile) async {
    try {
      const cloudName = 'YOUR_CLOUD_NAME';
      const uploadPreset = 'YOUR_UPLOAD_PRESET';
      
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = 'milestone_radio'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      
      final response = await request.send();
      
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = json.decode(responseString);
        return jsonMap['secure_url'];
      } else {
        print('Cloudinary upload failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }

  void _saveArticle() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final article = Article(
        id: widget.article?.id,
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        category: _selectedCategory,
        featuredImage: _featuredImageUrl,
        excerpt: _excerptController.text.trim(),
        content: _contentController.text.trim(),
        createdAt: widget.article?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      try {
        if (widget.article == null) {
          await context.read<ArticleProvider>().addArticle(article);
        } else {
          await context.read<ArticleProvider>().updateArticle(widget.article!.id!, article);
        }

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.article == null ? 'Article created successfully!' : 'Article updated successfully!',
              ),
              backgroundColor: AppTheme.milestoneBlue,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error saving article. Please try again.'),
              backgroundColor: AppTheme.milestoneRed,
            ),
          );
        }
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
