import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:milestoneradio/screens/articles_screen.dart';
import 'package:milestoneradio/screens/radio_screen.dart';
import 'package:milestoneradio/screens/about_screen.dart';
import '../utils/theme.dart';
import '../widgets/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late WebViewController _persistentWebViewController;
  bool _isWebViewLoading = true;
  bool _showMiniPlayer = false;

  @override
  void initState() {
    super.initState();
    _initializePersistentWebView();
  }

  void _initializePersistentWebView() {
    _persistentWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isWebViewLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isWebViewLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://a4.asurahosting.com/public/milestone/embed?theme=light'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.milestoneGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/milestone-logo.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 15),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MILESTONE RADIO',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Live Educational Broadcasting',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Mini player toggle when not on radio screen
                    if (_currentIndex != 0 && _showMiniPlayer)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0; // Go to radio screen
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.radio,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/admin');
                      },
                      icon: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        _buildCurrentScreen(),
                        
                        // Hidden persistent WebView (always loaded but only visible on radio screen)
                        Positioned(
                          left: -9999, // Hide off-screen when not radio screen
                          top: -9999,
                          child: _currentIndex == 0 ? const SizedBox.shrink() : SizedBox(
                            width: 1,
                            height: 1,
                            child: WebViewWidget(controller: _persistentWebViewController),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Mini Player Bar (shows when not on radio screen and radio is playing)
              if (_currentIndex != 0 && _showMiniPlayer)
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.milestoneBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.radio,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Milestone Radio',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Live Broadcasting',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0; // Go to full radio screen
                            });
                          },
                          icon: const Icon(
                            Icons.open_in_full,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            // When leaving radio screen, show mini player
            if (_currentIndex == 0 && index != 0) {
              _showMiniPlayer = true;
            }
            // When returning to radio screen, hide mini player
            if (index == 0) {
              _showMiniPlayer = false;
            }
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        // Pass the persistent WebViewController to RadioScreen
        return RadioScreen(webViewController: _persistentWebViewController, isLoading: _isWebViewLoading);
      case 1:
        return const ArticlesScreen();
      case 2:
        return const AboutScreen();
      default:
        return RadioScreen(webViewController: _persistentWebViewController, isLoading: _isWebViewLoading);
    }
  }
}