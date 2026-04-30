import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/providers/home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp.router(
        title: 'Hilcom - Where quality is sold',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
