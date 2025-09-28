import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/radio_screen.dart';
import 'screens/articles_screen.dart';
import 'screens/admin_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/article_provider.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB07c5ehb9CV4i6mYrR8zPfM_d6KttjVlU",
      authDomain: "milestone-95d76.firebaseapp.com",
      projectId: "milestone-95d76",
      storageBucket: "milestone-95d76.firebasestorage.app",
      messagingSenderId: "417561933725",
      appId: "1:417561933725:web:261688d5031778019e6174",
      measurementId: "G-EEL8GH4X60",
    ),
  );
  
  runApp(const MilestoneRadioApp());
}

class MilestoneRadioApp extends StatelessWidget {
  const MilestoneRadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
      ],
      child: MaterialApp(
        title: 'Milestone Radio',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/radio': (context) => const RadioScreen(),
          '/articles': (context) => const ArticlesScreen(),
          '/admin': (context) => const AdminScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
