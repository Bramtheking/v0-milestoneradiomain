import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Header Section
            const Text(
              'About Milestone Radio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.milestoneNavy,
              ),
            ),
            const SizedBox(height: 10),
            
            const Text(
              'Your Gateway to Excellence - Connecting education, community, and inspiring stories.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Logo/Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.milestoneBlue, AppTheme.milestoneBlue.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.milestoneBlue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.radio,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'MILESTONE RADIO',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Inspiring Greatness in Education',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // About Section
            _buildInfoCard(
              'Our Mission',
              'Milestone Radio serves as the official digital broadcasting platform of Milestone Institute of Professional Studies. We provide quality educational content, promote academic excellence, and foster a culture of continuous learning through innovative radio programming.',
              Icons.flag_outlined,
              AppTheme.milestoneBlue,
            ),

            const SizedBox(height: 20),

            // About Institute
            _buildInfoCard(
              'About Milestone Institute',
              'Milestone Institute of Professional Studies is a leading educational institution committed to providing exceptional academic programs. We offer diverse professional studies including Computer Studies & ICT, Journalism & Media, and comprehensive career development programs.',
              Icons.school_outlined,
              AppTheme.milestoneCyan,
            ),

            const SizedBox(height: 20),

            // Features Grid
            const Text(
              'What We Offer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.milestoneNavy,
              ),
            ),
            const SizedBox(height: 15),
            
            Row(
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    '🎵',
                    'Live Streaming',
                    '24/7 educational broadcasts',
                    AppTheme.milestoneBlue,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildFeatureCard(
                    '📰',
                    'Latest Articles',
                    'Educational content & news',
                    AppTheme.milestoneRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            
            Row(
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    '🎧',
                    'Quality Audio',
                    'Crystal clear streaming',
                    AppTheme.milestoneGold,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildFeatureCard(
                    '👥',
                    'Community',
                    'Connect with learners',
                    AppTheme.milestoneCyan,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Contact Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppTheme.milestoneBlue.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.milestoneBlue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_support_outlined,
                        color: AppTheme.milestoneBlue,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Connect With Us',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.milestoneNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  InkWell(
                    onTap: () => _launchURL('tel:0712403409'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppTheme.milestoneBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Main Campus - Thika',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.milestoneNavy,
                                  ),
                                ),
                                Text(
                                  '0712 403 409 / 0722 972 438',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Divider(height: 20),
                  
                  InkWell(
                    onTap: () => _launchURL('https://www.milestoneinstitute.ac.ke'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.web,
                            color: AppTheme.milestoneBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Visit Our Website',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.milestoneNavy,
                                  ),
                                ),
                                Text(
                                  'www.milestoneinstitute.ac.ke',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Divider(height: 20),
                  
                  InkWell(
                    onTap: () => _launchURL('mailto:info@milestoneinstitute.ac.ke'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: AppTheme.milestoneBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email Us',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.milestoneNavy,
                                  ),
                                ),
                                Text(
                                  'info@milestoneinstitute.ac.ke',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Divider(height: 20),
                  
                  const Text(
                    'Other Campuses:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.milestoneNavy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  _buildCampusContactItem('Nairobi', '0796 553 553'),
                  _buildCampusContactItem('Mombasa', '0797 585 594'),
                  _buildCampusContactItem('Nakuru', '0769 358 606'),
                  _buildCampusContactItem('Eldoret', '0790 553 553'),
                  _buildCampusContactItem('Kisumu', '0713 535 565'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // App Info
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.milestoneBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      'Milestone Radio App v1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.milestoneBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '© 2024 Milestone Institute of Professional Studies',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'All Rights Reserved',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String emoji, String title, String description, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCampusContactItem(String campus, String phone) {
    return InkWell(
      onTap: () => _launchURL('tel:${phone.replaceAll(' ', '')}'),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const Icon(
              Icons.location_city,
              color: AppTheme.milestoneBlue,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                campus,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.milestoneNavy,
                ),
              ),
            ),
            Text(
              phone,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.grey,
            ),
          ],
        ),
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