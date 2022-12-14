import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MapPage();
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late CameraPosition cameraPosition;
  late GoogleMapController mapController;
  final mapZoom = 17.0;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getUserLocation() async {
    await Geolocator.requestPermission();
    final response = await Geolocator.checkPermission();
    if(response == LocationPermission.always || response == LocationPermission.whileInUse){
      final userPosition = await Geolocator.getCurrentPosition();
      _changeCameraPosition(userPosition.latitude, userPosition.longitude);
    }


  }

  void _changeCameraPosition(double latitude, double longitude) {
    cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: mapZoom,
    );
    mapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target:
      const LatLng(
        41.3515292,
        69.2872785,
      ),
      zoom: mapZoom,
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: cameraPosition,
        ),
        Positioned(
          top: 32,
          right: 16,
          child: Container(
            decoration: getContainerDecoration(
              context,
              fillColor: getCurrentTheme(context).cardColor,
            ),
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: _getUserLocation,
              child: const Icon(
                Icons.location_searching_outlined,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
