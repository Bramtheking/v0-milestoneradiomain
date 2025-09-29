import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
}