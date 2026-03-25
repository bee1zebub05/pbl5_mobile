import 'package:flutter/material.dart';
import 'package:pbl5_mobile/src/common/utils/getit_utils.dart';
import 'package:pbl5_mobile/src/core/router/app_router.dart';

void main() async {
  configureDependencies();
  //await HiveInitService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Color Analysis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}