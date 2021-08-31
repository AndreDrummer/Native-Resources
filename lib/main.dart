import 'package:flutter/material.dart';
import 'package:native_resources/providers/great_places.dart';
import 'package:native_resources/screens/place_form_screen.dart';
import 'package:native_resources/screens/places_list_screens.dart';
import 'package:native_resources/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.placeForm: (ctx) => PlaceFormScreen(),
        },
      ),
    );
  }
}
