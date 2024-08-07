import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/daftar_seminar_screen/daftar_seminar_screen.dart';
import '../presentation/dashboard_screen/dashboard_screen.dart';
import '../presentation/detail_screen/detail_screen.dart';
import '../presentation/kerja_praktek_screen/kerja_praktek_screen.dart';
import '../presentation/seminar_screen/seminar_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';

class AppRoutes {
  static const String dashboardScreen = '/dashboard_screen';
  static const String detailScreen = '/detail_screen';
  static const String daftarSeminarScreen = '/daftar_seminar_screen';
  static const String seminarScreen = '/seminar_screen';
  static const String kerjaPraktekScreen = '/kerja_praktek_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String loginScreen = '/login_screen';
  static const String profileScreen = '/profile_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    dashboardScreen: (context) => DashboardScreen(),
    detailScreen: (context) => DetailScreen(),
    daftarSeminarScreen: (context) => DaftarSeminarScreen(),
    seminarScreen: (context) => SeminarScreen(),
    kerjaPraktekScreen: (context) => KerjaPraktekScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    loginScreen: (context) => LoginScreen(),
    profileScreen: (context) => ProfileScreen(),
    initialRoute: (context) => AppNavigationScreen()
  };
}
