import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_time_tracking_project/tracking_service.dart';

import 'vehicle.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late final BitmapDescriptor bitMap;

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(
      30.372882,
      30.500178,
    ),
    zoom: 17,
  );

  @override
  void initState() {
    TrackingService.init();
    _loadBitMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: TrackingService.nearestVehicles,
        builder: ((context, snapshot) {
          if (snapshot.connectionState.name == ConnectionState.waiting.name) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == null) {
            return Text('No Data Found');
          }

          if (snapshot.data?.isNotEmpty ?? false) {
            return GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.terrain,
              initialCameraPosition: _cameraPosition,
              markers: _mapVehicleToMarks(snapshot.data ?? []),
            );
          }

          return Container();
        }),
      )),
    );
  }

  Set<Marker> _mapVehicleToMarks(List<Vehicle> vehicles) {
    final markers = <Marker>{};
    for (final v in vehicles) {
      markers.add(Marker(
          markerId: MarkerId(v.id.toString()),
          icon: bitMap,
          position: LatLng(v.lat, v.lon)));
    }
    return markers;
  }

  void _loadBitMap() async {
    bitMap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      "assets/car.png",
    );
  }

  @override
  void dispose() {
    TrackingService.stopTracking();
    super.dispose();
  }
}
