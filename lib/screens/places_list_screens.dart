import 'package:flutter/material.dart';
import 'package:native_resources/providers/great_places.dart';
import 'package:native_resources/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus lugares'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text('Nenhum local cadastrado'),
                    ),
                    builder: (ctx, greatPlaces, child) =>
                        greatPlaces.itemsCount == 0
                            ? child!
                            : ListView.builder(
                                itemCount: greatPlaces.itemsCount,
                                itemBuilder: (ctx, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                      greatPlaces.getItemByIndex(index).image,
                                    ),
                                  ),
                                  title: Text(
                                      greatPlaces.getItemByIndex(index).title),
                                ),
                              ),
                  );
          }),
    );
  }
}
