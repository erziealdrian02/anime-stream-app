import 'package:flutter/material.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';

class AnimeStreamApp extends StatelessWidget {
  const AnimeStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anime Stream',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
