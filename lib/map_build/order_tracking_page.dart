import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'constants.dart';


class OrderTrackPage extends StatefulWidget {
  const OrderTrackPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackPage> createState() => _OrderTrackPageState();
}

class _OrderTrackPageState extends State<OrderTrackPage> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];

  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon  = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13.5,
          target: LatLng(
            newLoc.latitude!,
            newLoc.longitude!,
          ),
        ),
      ));
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      StringConstants.googleApiKey,
      PointLatLng(StringConstants.sourceLocation.latitude, StringConstants.sourceLocation.longitude),
      PointLatLng(StringConstants.destination.latitude, StringConstants.destination.longitude),
      travelMode: TravelMode.driving,
    );
    debugPrint('my points');
    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    } else {
      debugPrint('error: ${result.errorMessage}');
    }
  }

  // void setCustomMarkerIcon(){
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/icons/sourceIcon.png').then((icon) {
  //   sourceIcon=icon;
  //   },);
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/icons/destinationIcon.png').then((icon) {
  //     destinationIcon=icon;
  //   },);
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/icons/currentLoctionIcon.png').then((icon) {
  //     currentLocationIcon = icon;
  //   },);
  // }

  @override
  void initState() {
    // getCurrentLocation();
    // setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      // (currentLocation == null)
      //     ? Center(
      //         child: Column(
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           CircularProgressIndicator(),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Text(
      //             'Loading...',
      //             style: TextStyle(
      //               color: Colors.black54,
      //               fontSize: 20,
      //             ),
      //           )
      //         ],
      //       )) :
      GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(StringConstants.sourceLocation.latitude,StringConstants.sourceLocation.longitude),
                // target: LatLng(
                //     currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  color: StringConstants.primaryColor,
                  width: 6,
                ),
              },
              markers: {
                // Marker(
                //     markerId: const MarkerId('currentLocation'),
                //     position: LatLng(currentLocation!.latitude!,
                //         currentLocation!.longitude!),
                //     icon: BitmapDescriptor.defaultMarker),
                 Marker(
                    markerId: const MarkerId('source'),
                    position: StringConstants.sourceLocation,
                    icon: BitmapDescriptor.defaultMarker),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: StringConstants.destination,
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            );
  }
}
