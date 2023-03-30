import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final double lat, lng;
  const MapWidget({Key? key, required this.lat, required this.lng})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(widget.lat, widget.lng),
      // icon: BitmapDescriptor.,
      infoWindow: const InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(

      zoomGesturesEnabled: true,
      tiltGesturesEnabled: false,
      padding: const EdgeInsets.only(top: 100),
      mapType: MapType.normal,
      myLocationEnabled: true,
      onMapCreated: _onMapCreated,
      markers: markers.values.toSet(),
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.lat, widget.lng),
        zoom: 14.0,
      ),
      onCameraMove: (CameraPosition position) {
        print (LatLng(widget.lat, widget.lng));
      },
      onCameraIdle: () {},
    );
  }
}
