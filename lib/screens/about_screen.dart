import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'About Milestone Radio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Logo
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.milestoneBlue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.milestoneBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.radio,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Milestone Radio',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Your Gateway to Excellence',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // About Section
            _buildSection(
              'About Milestone Radio',
              'Milestone Radio is the official digital radio platform of Milestone Institute of Professional Studies, bringing you closer to academic excellence and professional development. Our radio serves as a bridge connecting students, faculty, and the broader community through engaging content, educational programs, and inspiring stories.',
              Icons.info_outline,
            ),

            const SizedBox(height: 20),

            // Mission Section
            _buildSection(
              'Our Mission',
              'To provide quality educational content, promote academic excellence, and foster a culture of continuous learning through innovative radio programming. We aim to inspire greatness in education while keeping our community informed and engaged.',
              Icons.flag_outlined,
            ),

            const SizedBox(height: 20),

            // About Milestone Institute
            _buildSection(
              'About Milestone Institute',
              'Milestone Institute of Professional Studies is a leading educational institution committed to providing exceptional academic programs and fostering a culture of excellence. Founded with a vision to empower individuals with the knowledge and skills necessary for success in their chosen fields, we offer diverse professional studies tailored to meet the evolving needs of today\'s workforce.',
              Icons.school_outlined,
            ),

            const SizedBox(height: 20),

            // Programs Section
            _buildSection(
              'Academic Excellence',
              'Our radio content reflects the diverse academic programs offered at Milestone Institute, including:\n\n• School of Computer Studies & ICT\n• School of Journalism & Media\n• Professional Development Programs\n• Career Guidance and Counseling\n• Student Success Stories',
              Icons.star_outline,
            ),

            const SizedBox(height: 20),

            // Features Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppTheme.milestoneBlue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.featured_play_list_outlined,
                        color: AppTheme.milestoneBlue,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'App Features',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureItem('🎵', 'Live Radio Streaming', 'Listen to our live broadcasts 24/7'),
                  _buildFeatureItem('📰', 'Educational Articles', 'Read the latest educational content and news'),
                  _buildFeatureItem('🎧', 'High Quality Audio', 'Crystal clear streaming experience'),
                  _buildFeatureItem('📱', 'User-Friendly Interface', 'Easy navigation and modern design'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Contact Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.milestoneBlue, AppTheme.milestoneBlue.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connect With Us',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () => _launchURL('https://milestoneinstitute.ac.ke'),
                    child: _buildContactItem(
                      Icons.web,
                      'Visit Our Website',
                      'milestoneinstitute.ac.ke',
                    ),
                  ),
                  InkWell(
                    onTap: () => _launchURL('mailto:info@milestoneinstitute.ac.ke'),
                    child: _buildContactItem(
                      Icons.email_outlined,
                      'Email Us',
                      'info@milestoneinstitute.ac.ke',
                    ),
                  ),
                  _buildContactItem(
                    Icons.location_on_outlined,
                    'Our Locations',
                    'Multiple campuses across Kenya',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    'Milestone Radio App',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '© 2024 Milestone Institute of Professional Studies',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Inspiring Greatness in Education',
                    style: TextStyle(
                      color: AppTheme.milestoneBlue,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.milestoneBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppTheme.milestoneBlue,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white70,
            size: 16,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}