import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_theme.dart';

class EmaApp extends StatelessWidget {
  const EmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EMA Mobile',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,

      // Router
      routerConfig: appRouter,
    );
  }
}