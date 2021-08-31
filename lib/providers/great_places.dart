import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:native_resources/models/place.dart';
import 'package:native_resources/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = List<Place>.from(
      dataList.map(
        (e) => Place.fromMap(e),
      ),
    ).toList();
    notifyListeners();
  }

  List<Place> get items {
    return [...items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        address: '',
        latitude: 1,
        longitude: 2,
      ),
    );

    _items.add(newPlace);
    DbUtil.insert('places', newPlace.toMap());
    notifyListeners();
  }
}
