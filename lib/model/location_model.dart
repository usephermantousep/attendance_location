part of 'models.dart';

class LocationModel extends Equatable {
  final String? id;
  final String locationName;
  final double radius;
  final double lat;
  final double long;

  const LocationModel({
    this.id,
    required this.locationName,
    required this.radius,
    required this.lat,
    required this.long,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['_id'],
        locationName: json['location_name'],
        radius: double.parse(json['radius'].toString()),
        lat: double.parse(json['lat'].toString()),
        long: double.parse(json['long'].toString()),
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'location_name': locationName,
      'radius': radius,
      'lat': lat,
      'long': long,
    };
  }

  @override
  List<Object?> get props => [
        id,
        locationName,
        radius,
        lat,
        long,
      ];
}
