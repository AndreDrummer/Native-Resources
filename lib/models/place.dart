import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.longitude,
    required this.latitude,
    required this.address,
  });
}

class Place {
  final PlaceLocation? location;
  final String title;
  final File image;
  final String id;

  Place({
    this.location,
    required this.title,
    required this.image,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image.path,
      'title': title,
      'id': id,
    };
  }

  factory Place.fromMap(Map<String, dynamic> data) {
    return Place(
      image: File(data['image']),
      title: data['title'],
      id: data['id'],
    );
  }
}
