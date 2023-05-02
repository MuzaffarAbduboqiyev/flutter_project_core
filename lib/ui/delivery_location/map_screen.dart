import 'package:delivery_service/controller/location_controller/location_bloc.dart';
import 'package:delivery_service/controller/location_controller/location_event.dart';
import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:delivery_service/ui/delivery_location/location_indicator.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as webService;
import 'package:google_maps_webservice/places.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(
        LocationState.initial(),
        locationRepository: singleton(),
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

const kGoogleApiKey = "AIzaSyAJaKaz4zx7fXm1jy8MB24Cxvs_Kx-26Qk";

class _MapPageState extends State<MapPage> {
  late CameraPosition cameraPosition;
  late GoogleMapController mapController;
  late TextEditingController textLocationController;
  late TextEditingController locationController;
  late SuggestionsBoxController _suggestionsBoxController;

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
    cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: mapZoom,
    );
    EasyDebounce.debounce(
      'get_location_info',
      const Duration(milliseconds: 500),
      _getLocationInfo,
    );
  }

  void _getLocationInfo() {
    context.read<LocationBloc>().add(
          LocationGetInfoEvent(
            lat: cameraPosition.target.latitude.toString(),
            lng: cameraPosition.target.longitude.toString(),
          ),
        );
  }

  /// clear location text
  _clearLocation() {
    locationController.clear();
    _suggestionsBoxController.close();
  }

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: const LatLng(41.3515292, 69.2872785),
      zoom: mapZoom,
    );
    textLocationController = TextEditingController();
    locationController = TextEditingController();
    _suggestionsBoxController = SuggestionsBoxController();
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
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: cameraPosition,
              onMapCreated: _onMapCreated,
              onCameraMove: (position) {
                updateCamera(
                  position.target.latitude,
                  position.target.longitude,
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 14),
                  child: TypeAheadField<Prediction>(
                    suggestionsBoxController: _suggestionsBoxController,
                    getImmediateSuggestions: true,
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: _clearLocation,
                            child:
                                const Icon(Icons.clear, color: Colors.white)),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.white),
                        hintStyle: getCurrentTheme(context).textTheme.bodyLarge,
                        border: const OutlineInputBorder(),
                        hintText: translate("location.search"),
                      ),
                      minLines: 1,
                      maxLines: 3,
                      autofocus: true,
                      controller: locationController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.search,
                      textCapitalization: TextCapitalization.words,
                    ),
                    suggestionsCallback: (searchName) async {
                      GoogleMapsPlaces places =
                          GoogleMapsPlaces(apiKey: kGoogleApiKey);
                      final query = await places.autocomplete(
                        searchName,
                        language: "uz",
                        components: [
                          webService.Component(
                              webService.Component.country, "uz")
                        ],
                      );
                      return query.predictions;
                    },
                    itemBuilder: (context, saleProduct) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: ListTile(
                        leading: const Icon(Icons.location_on_sharp, size: 30),
                        title: Text(saleProduct.description ?? ""),
                      ),
                    ),
                    onSuggestionSelected: (selectedItem) async {
                      GoogleMapsPlaces places =
                          GoogleMapsPlaces(apiKey: kGoogleApiKey);
                      PlacesDetailsResponse detail = await places
                          .getDetailsByPlaceId(selectedItem.placeId ?? "");
                      double lat = detail.result.geometry?.location.lat ?? 0;
                      double lng = detail.result.geometry?.location.lng ?? 0;
                      // ignore: use_build_context_synchronously
                      context.read<LocationBloc>().add(LocationGetInfoEvent(
                          lat: lat.toString(), lng: lng.toString()));
                      _changeCameraPosition(lat, lng);
                    },
                  ),
                ),
                InkWell(
                  onTap: _getUserLocation,
                  child: Container(
                    decoration: getContainerDecoration(
                      context,
                      fillColor: getCurrentTheme(context).cardColor,
                    ),
                    margin: const EdgeInsets.all(14),
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      Icons.location_searching_outlined,
                      color: errorTextColor,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) => Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Text(
                    state.locationData.address,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.location_on_sharp,
                color: Colors.red,
                size: 40,
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()),
                const LocationIndicator()
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showSearch() async {
    final p = await PlacesAutocomplete.show(
        context: context,
        radius: 30000,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: Mode.overlay,
        language: 'uz',
        hint: "Search...",
        logo: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset("assets/img/google_white.svg"),
        ),
        backArrowIcon: SvgPicture.asset("assets/img/google_white.png"),
        components: [webService.Component(webService.Component.country, 'uz')]);

    if (p != null) {
      GoogleMapsPlaces mapsPlaces = GoogleMapsPlaces(apiKey: kGoogleApiKey);
      PlacesDetailsResponse detailResponse =
          await mapsPlaces.getDetailsByPlaceId(p.placeId ?? "");
      double lat = detailResponse.result.geometry?.location.lat ?? 0;
      double lng = detailResponse.result.geometry?.location.lng ?? 0;
      _changeCameraPosition(lat, lng);
    }
  }

  onError(value) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Location Error"),
      ),
    );
  }
}
