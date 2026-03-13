import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'providers/places_provider.dart';
import 'providers/hotels_provider.dart';
import 'providers/hidden_spots_provider.dart';

class NadodiApp extends StatelessWidget {
  const NadodiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlacesProvider()),
        ChangeNotifierProvider(create: (_) => HotelsProvider()),
        ChangeNotifierProvider(create: (_) => HiddenSpotsProvider()),
      ],
      child: MaterialApp(
        title: 'Nadodi - Kerala Tourism Explorer',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
          ),
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}