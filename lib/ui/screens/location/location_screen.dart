import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/controllers/location_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/location_widegts/location_widget.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(12, 12)), ImageAssets.customPin)
        .then((d) {
      setState(() {
        customIcon = d;
      });
    });
    _getUserLocation();
  }

  Completer<GoogleMapController> _controller = Completer();

  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  LatLng? currentPostion;
  String _currentAddress = '';
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  // final TextEditingController _searchController = TextEditingController();

  void _getUserLocation() async {
    _handleLocationPermission();
    getUserPermission();

    var position = await GeolocatorPlatform.instance.getCurrentPosition();

    _getAddressFromLatLng(position);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(currentPostion.toString()),
          position: currentPostion!,
          infoWindow: InfoWindow(
            title: _currentAddress,
          ),
          icon: customIcon,
        ),
      );
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        context.read<LocationProvider>().setAddress(_currentAddress);
      });
    });
  }

  void getUserPermission() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    _getAddressFromLatLng(await Geolocator.getCurrentPosition());
    return await Geolocator.getCurrentPosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {}

  void _onAddTapMarkerButtonPressed(LatLng latLng) {
    setState(
      () {
        _markers.clear();
        _getAddressFromLatLng(Position(
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            timestamp: null,
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0));

        _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(latLng.toString()),
            position: latLng,
            infoWindow: InfoWindow(
              title: _currentAddress,
            ),
            icon: customIcon,
          ),
        );
      },
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 12),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPostion == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: currentPostion!,
                            zoom: 18,
                          ),
                          mapType: _currentMapType,
                          markers: _markers,
                          onCameraMove: _onCameraMove,
                          onTap: (LatLng latlng) {
                            setState(() {
                              _onAddTapMarkerButtonPressed(latlng);
                            });
                          },
                        ),
                        height: MediaQuery.of(context).size.height * 0.8,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FloatingActionButton(
                                mini: true,
                                onPressed: fab_onpressed,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                backgroundColor: MyColors.primaryColor,
                                child: const Icon(Icons.my_location_rounded,
                                    size: 24.0),
                              ),
                            ),
                            locationWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void fab_onpressed() async {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());

      // marker added for current users location
      _markers.clear();
      _markers.add(
        Marker(
          draggable: true,
          markerId: MarkerId(value.toString()),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: _currentAddress,
          ),
          icon: customIcon,
        ),
      );

      // specified current users location
      CameraPosition cameraPosition = new CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 16,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }
}
