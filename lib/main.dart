import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import 'screens/places_list_screen.dart';
import 'screens/place_form_screen.dart';
import 'utils/app_routes.dart';
import 'providers/great_places.dart';

void main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.indigo,
    );
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            secondary: Colors.amber,
          ),
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.placeForm: (context) => const PlaceFormScreen(),
          AppRoutes.placeDetail: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
