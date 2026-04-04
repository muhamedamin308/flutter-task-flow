import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp_flutter_course/core/theme/app_theme.dart';
import 'package:freecodecamp_flutter_course/presentation/providers/auth_provider.dart';
import 'package:freecodecamp_flutter_course/presentation/providers/theme_provider.dart';
import 'package:freecodecamp_flutter_course/presentation/screens/auth/login_screen.dart';
import 'package:freecodecamp_flutter_course/presentation/screens/home/home_screen.dart';

class TaskFlowApp extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: authState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, _) =>
            Scaffold(body: Center(child: Text('Error: $error'))),
        data: (user) => user != null ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }
}
