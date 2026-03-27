import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';
import 'package:pbl5_mobile/src/common/utils/getit_utils.dart';
import 'package:pbl5_mobile/src/core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initApp();

  runApp(const MyApp());
}

/// init
Future<void> _initApp() async {
  configureDependencies();
  //await HiveInitService.init();
}

/// app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp.router(
        title: 'Color Analysis',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }

  /// theme
  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorName.primary,
      ),
      fontFamily: 'Inter',
    );
  }
}