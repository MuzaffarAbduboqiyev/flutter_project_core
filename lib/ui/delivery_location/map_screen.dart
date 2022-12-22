import 'package:delivery_service/controller/location_controller/location_bloc.dart';
import 'package:delivery_service/controller/location_controller/location_event.dart';
import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(
        LocationState.initial(),
        repository: singleton(),
      ),
      child: const MapPage(),
    );
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
    if (response == LocationPermission.always ||
        response == LocationPermission.whileInUse) {
      final userPosition = await Geolocator.getCurrentPosition();
      _changeCameraPosition(userPosition.latitude, userPosition.longitude);
    }
  }

  void _changeCameraPosition(double latitude, double longitude) {
    updateCamera(latitude, longitude);
    mapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void updateCamera(double latitude, double longitude) {
    context
        .read<LocationBloc>()
        .add(LocationGetInfoEvent(lat: latitude, lng: longitude,name: ''));
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: mapZoom,
      );
    });
  }

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: const LatLng(41.3515292, 69.2872785),
      zoom: mapZoom,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state.locationStatus == LocationStatus.closed) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: cameraPosition,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onCameraMove: (position) {
                updateCamera(
                    position.target.latitude, position.target.longitude);
              },
            ),
            Positioned(
              top: 24,
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
            Positioned(
              top: 32,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 60),
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      state.locationData.name ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: getCustomStyle(
                          context: context,
                          color: lightTextColor,
                          textSize: 22),
                    ),
                  ),
                );
              },
            ),
            const Center(
              child: Icon(
                Icons.location_on_sharp,
                color: Colors.red,
                size: 32,
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) =>
                      (state.locationStatus == LocationStatus.loading)
                          ? const Padding(
                              padding: EdgeInsets.only(bottom: 28),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: buttonCart,
                              child: Container(
                                height: 53,
                                decoration: getContainerDecoration(context,
                                    fillColor: getCurrentTheme(context)
                                        .indicatorColor),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Center(
                                  child: Text(
                                    translate("confirmation").toCapitalized(),
                                    style: getCustomStyle(
                                      context: context,
                                      color: navSelectedTextColor,
                                      textSize: 15,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buttonCart() {
    context.read<LocationBloc>().add(LocationSaveEvent());
  }
}

