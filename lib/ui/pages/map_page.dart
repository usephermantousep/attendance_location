part of 'pages.dart';

class MapPage extends StatelessWidget {
  final LocationModel location;
  final Completer<GoogleMapController> _controller = Completer();
  MapPage({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      Marker(
        position: LatLng(location.lat, location.long),
        markerId: MarkerId(
          location.locationName,
        ),
        infoWindow: InfoWindow(title: location.locationName),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
    Set<Circle> circle = {
      Circle(
          circleId: CircleId(location.locationName),
          center: LatLng(location.lat, location.long),
          fillColor: Colors.red[200]!.withOpacity(0.5),
          strokeColor: Colors.red,
          strokeWidth: 0,
          radius: location.radius),
    };
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(location.lat, location.long),
            zoom: 15,
          ),
          markers: markers,
          circles: circle,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
