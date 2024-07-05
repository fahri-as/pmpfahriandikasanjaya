import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:pmpfahriandikasanjaya/presentation/daftar_seminar_screen/daftar_seminar_screen.dart';
import 'package:pmpfahriandikasanjaya/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:pmpfahriandikasanjaya/presentation/detail_screen/detail_screen.dart';
import 'package:pmpfahriandikasanjaya/presentation/kerja_praktek_screen/kerja_praktek_screen.dart';
import 'package:pmpfahriandikasanjaya/presentation/seminar_screen/seminar_screen.dart';
import 'package:pmpfahriandikasanjaya/presentation/profile_screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');

  // Check for saved token
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String initialRoute =
      token == null ? AppRoutes.loginScreen : AppRoutes.dashboardScreen;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatefulWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    DashboardScreen(),
    DetailScreen(),
    DaftarSeminarScreen(),
    SeminarScreen(),
    KerjaPraktekScreen(),
    ProfileScreen(), // Add ProfileScreen to the list
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'pmpfahriandikasanjaya',
          debugShowCheckedModeBanner: false,
          initialRoute: widget.initialRoute,
          routes: AppRoutes.routes,
          home: Scaffold(
            body: _screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.details),
                  label: 'Details',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Daftar Seminar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Seminar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: 'Kerja Praktek',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile', // Add profile label
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        );
      },
    );
  }
}
