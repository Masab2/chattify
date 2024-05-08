import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Model/ProfileModel/ProfileModel.dart';
import 'package:chattify/Views/Auth/LoginView/LoginView.dart';
import 'package:chattify/Views/Auth/SignUp/SignUpView.dart';
import 'package:chattify/Views/BottomNavBar/BottomNavBar.dart';
import 'package:chattify/Views/Chat/ChatScreen/ChatScreen.dart';
import 'package:chattify/Views/Chat/HomeScreen.dart';
import 'package:chattify/Views/Contact/ContactScreen.dart';
import 'package:chattify/Views/Profile/ProfileScreen.dart';
import 'package:chattify/Views/Profile/Update/UpdateProfileScreen.dart';
import 'package:chattify/Views/SplashScreen/SplashView.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesNames.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case RoutesNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RoutesNames.contactScreen:
        return MaterialPageRoute(
          builder: (context) => const ContactScreenView(),
        );
      case RoutesNames.notifScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RoutesNames.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case RoutesNames.bottomScreen:
        return MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        );
      case RoutesNames.updateProfileScreen:
        return MaterialPageRoute(
          builder: (context) => UpdateProfile(
            args: args as ProfileModel,
          ),
        );
     
      case RoutesNames.chatMessageScreen:
        return MaterialPageRoute(
          builder: (context) => ChatScreenView(
            model: args as ContactModel,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
