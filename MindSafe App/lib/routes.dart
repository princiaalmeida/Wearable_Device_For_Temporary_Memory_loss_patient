import 'package:flutter/material.dart';

// Import all your screens
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/gps/gps_screen.dart';
import 'screens/vitals/vitals_screen.dart';
import 'screens/reminder/reminder_screen.dart';
import 'screens/alert/alert_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';

class Routes {
  // Define all route names
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String gps = '/gps';
  static const String vitals = '/vitals';
  static const String reminder = '/reminder';
  static const String forgotPassword = '/forgot-password';
  static const String alert = '/alert';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case gps:
        return MaterialPageRoute(builder: (_) => GpsScreen());
      case vitals:
        return MaterialPageRoute(builder: (_) => VitalsScreen());
      case reminder:
        return MaterialPageRoute(builder: (_) => ReminderScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case alert:
        return MaterialPageRoute(builder: (_) => AlertScreen());
      default:
      // Unknown route fallback
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'Page not found!',
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            ),
          ),
        );
    }
  }
}
