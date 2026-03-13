import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/place_detail_screen.dart';
import 'screens/hidden_places_screen.dart';
import 'screens/saved_places_screen.dart';
import 'screens/profile_screen.dart';
import 'models/place_model.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String placeDetail = '/place-detail';
  static const String map = '/map';
  static const String hidden = '/hidden';
  static const String saved = '/saved';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case placeDetail:
        final place = settings.arguments as TouristPlace;
        return MaterialPageRoute(
          builder: (_) => PlaceDetailScreen(place: place),
        );

      case map:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Map Screen Coming Soon'),
            ),
          ),
        );

      case hidden:
        return MaterialPageRoute(builder: (_) => const HiddenPlacesScreen());

      case saved:
        return MaterialPageRoute(builder: (_) => const SavedPlacesScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}