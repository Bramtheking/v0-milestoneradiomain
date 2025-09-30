import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/theme.dart';
import '../widgets/live_indicator.dart';
import '../widgets/click_to_play_instructions.dart';

class RadioScreen extends StatelessWidget {
  final WebViewController webViewController;
  final bool isLoading;

  const RadioScreen({
    super.key,
    required this.webViewController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            const Text(
              'MILESTONE RADIO',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.milestoneNavy,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Live Educational Broadcasting',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.milestoneBlue,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            const LiveIndicator(),
            const SizedBox(height: 30),
            
            const ClickToPlayInstructions(),
            const SizedBox(height: 20),
            
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.milestoneBlue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    WebViewWidget(controller: webViewController),
                    if (isLoading)
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.milestoneBlue,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            _buildActionButtons(context),
            const SizedBox(height: 40),
            
            _buildStudentLifeSection(),
            const SizedBox(height: 40),
            
            _buildCoursesSection(),
            const SizedBox(height: 40),
            
            _buildBootcampSection(),
            const SizedBox(height: 40),
            
            _buildConnectWithUsSection(),
            const SizedBox(height: 40),
            
            _buildFeatureHighlights(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureHighlights() {
    return Column(
      children: [
        const Text(
          'Why Choose Milestone Radio?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.milestoneNavy,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        
        Row(
          children: [
            Expanded(
              child: _buildFeatureCard(
                icon: Icons.radio,
                title: 'Live Broadcasting',
                description: '24/7 live educational content, inspiring stories, and community connection.',
                color: AppTheme.milestoneBlue,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildFeatureCard(
                icon: Icons.article,
                title: 'Latest Articles',
                description: 'Stay informed with the latest stories and educational content from Milestone Radio.',
                color: AppTheme.milestoneCyan,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        
        Row(
          children: [
            Expanded(
              child: _buildFeatureCard(
                icon: Icons.people,
                title: 'Community Focus',
                description: 'Building connections and fostering growth within our educational community.',
                color: AppTheme.milestoneRed,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildFeatureCard(
                icon: Icons.school,
                title: 'Quality Education',
                description: 'Expert hosts and quality content designed to inspire and educate our listeners.',
                color: AppTheme.milestoneGold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
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
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _launchURL('https://portal.milestoneinstitute.ac.ke/admissionv2?cid=Sm+BFwHAOCU/R+Rv3s4GpQ=='),
            icon: const Icon(Icons.school, color: Colors.white),
            label: const Text(
              'Apply Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.milestoneBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _launchURL('https://portal.milestoneinstitute.ac.ke/enquiries?cid=Sm+BFwHAOCU/R+Rv3s4GpQ=='),
            icon: const Icon(Icons.contact_support, color: Colors.white),
            label: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.milestoneRed,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentLifeSection() {
    final studentLifeImages = [
      'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/475436142_1175846694547061_4469541777970975922_n-1024x683.jpg',
      'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/475804520_487863067692832_7990672667242762532_n.jpg',
      'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/480869411_1175846771213720_6867826558425827132_n.jpg',
      'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/475742474_498820523263753_2843325902764876369_n-1024x683.jpg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Student's Life @ Milestone Institute",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.milestoneNavy,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: studentLifeImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: studentLifeImages[index],
                    width: 280,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 280,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 280,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, size: 50),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCoursesSection() {
    final courses = [
      {'name': 'School of HealthCare Assistants', 'image': 'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/475804520_487863067692832_7990672667242762532_n.jpg'},
      {'name': 'School of Health Sciences', 'image': 'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/14-1.jpg'},
      {'name': 'School of Applied Sciences', 'image': 'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/08/31-scaled.jpg'},
      {'name': 'School of ICT', 'image': 'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/476599015_498820439930428_5342506736353469420_n.jpg'},
      {'name': 'School of Engineering', 'image': 'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/17.jpg'},
      {'name': 'School of Journalism & Media', 'image': 'https://www.milestoneinstitute.ac.ke/wp-content/uploads/2025/03/2.jpg'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Courses',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.milestoneNavy,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: courses[index]['image']!,
                          height: 140,
                          width: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 140,
                            color: Colors.grey.shade200,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 140,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, size: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          courses[index]['name']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.milestoneNavy,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBootcampSection() {
    final bootcampCourses = [
      {'name': 'SOFTWARE ENGINEERING BOOTCAMP', 'duration': '6 months'},
      {'name': 'DEVOPS ENGINEERING', 'duration': '3 months'},
      {'name': 'DATA SCIENCE BOOT CAMP', 'duration': '6 months'},
      {'name': 'DATA ANALYTICS', 'duration': '6 months'},
      {'name': 'DATA VISUALIZATION WITH PYTHON', 'duration': '3 months'},
      {'name': 'CYBER SECURITY BOOTCAMP', 'duration': '6 months'},
      {'name': 'CYBER SECURITY FOR BEGINNERS', 'duration': '3 months'},
      {'name': 'FRONTEND DEVELOPMENT', 'duration': '3 months'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MILESTONE TOP TECH BOOTCAMP COURSES',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.milestoneNavy,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
            children: bootcampCourses.map((course) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.milestoneBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.computer,
                        color: AppTheme.milestoneBlue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        course['name']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.milestoneNavy,
                        ),
                      ),
                    ),
                    Text(
                      course['duration']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildConnectWithUsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.milestoneBlue, AppTheme.milestoneBlue.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.milestoneBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
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
          const SizedBox(height: 20),
          _buildContactItem(
            Icons.phone,
            'Main Campus - Thika',
            '0712 403 409 / 0722 972 438',
            'tel:0712403409',
          ),
          const Divider(color: Colors.white30, height: 30),
          _buildContactItem(
            Icons.location_on,
            'Location',
            'Flame Tree Building, 1st Floor, Uhuru Street, Thika',
            null,
          ),
          const Divider(color: Colors.white30, height: 30),
          _buildContactItem(
            Icons.email,
            'Email',
            'info@milestoneinstitute.ac.ke',
            'mailto:info@milestoneinstitute.ac.ke',
          ),
          const SizedBox(height: 20),
          const Text(
            'Other Campuses:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _buildCampusItem('Nairobi', '0796 553 553'),
          _buildCampusItem('Mombasa', '0797 585 594'),
          _buildCampusItem('Nakuru', '0769 358 606'),
          _buildCampusItem('Eldoret', '0790 553 553'),
          _buildCampusItem('Kisumu', '0713 535 565'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String info, String? url) {
    return InkWell(
      onTap: url != null ? () => _launchURL(url) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (url != null)
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        ],
      ),
    );
  }

  Widget _buildCampusItem(String campus, String phone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.location_city, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              campus,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () => _launchURL('tel:${phone.replaceAll(' ', '')}'),
            child: Text(
              phone,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
                decoration: TextDecoration.underline,
              ),
            ),
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