import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'constants/app_theme.dart';
import 'constants/app_constants.dart';
import 'constants/app_colors.dart';
import 'providers/template_provider.dart';
import 'providers/user_project_provider.dart';
import 'providers/video_editor_provider.dart';
import 'providers/music_provider.dart';
import 'screens/main_navigation.dart';
import 'models/user_project.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AdMob
  await MobileAds.instance.initialize();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  // Note: Run 'flutter packages pub run build_runner build' to generate adapters
  // Hive.registerAdapter(UserProjectAdapter());

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.darkBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const StatusProApp());
}

class StatusProApp extends StatelessWidget {
  const StatusProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemplateProvider()),
        ChangeNotifierProvider(create: (_) => UserProjectProvider()),
        ChangeNotifierProvider(create: (_) => VideoEditorProvider()),
        ChangeNotifierProvider(create: (_) => MusicProvider()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainNavigation(),
      ),
    );
  }
}
