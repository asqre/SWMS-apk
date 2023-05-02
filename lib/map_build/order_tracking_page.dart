import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'constants.dart';



class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: StringConstants.nitjLocation,
    zoom: 17,
  );
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(31.394211, 75.533006),
    LatLng(31.394694914896295, 75.53370416170874),
    LatLng(31.395390929737093, 75.53500235084181),
    LatLng(31.39700273376199, 75.53164422507243),
    LatLng(31.392240505606097, 75.53606450563787),
    LatLng(31.393684875399046, 75.53671351078933),
    LatLng(31.393950280308367, 75.53730118106844),
    LatLng(31.39500346703969, 75.53748357129705),
    LatLng(31.39679843627001, 75.5372797234069),
    LatLng(31.39702738395901, 75.53628194162877),
    LatLng(31.399298514813694, 75.53579914400896),
    LatLng(31.39693571569256, 75.53393589450134),
    LatLng(31.396791304625427, 75.53522697843101),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < latlng.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: latlng[i],
            infoWindow: InfoWindow(
              title: 'Reality cool place',
              snippet: '5 star rating',
            ),
            icon: BitmapDescriptor.defaultMarker),
      );
      setState(() {});
      _polyline.add(
        Polyline(polylineId: PolylineId('1'), points: latlng,color: Colors.orange,width: 6,),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      polylines: _polyline,
      myLocationEnabled: true,
      initialCameraPosition: _kGooglePlex,
      mapType: MapType.normal,
    );
  }
}



// class OrderTrackPage extends StatefulWidget {
//   const OrderTrackPage({Key? key}) : super(key: key);
//
//   @override
//   State<OrderTrackPage> createState() => _OrderTrackPageState();
// }
//
// class _OrderTrackPageState extends State<OrderTrackPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   List<LatLng> polylineCoordinates = [];
//
//   LocationData? currentLocation;
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//
//   void getCurrentLocation() async {
//     Location location = Location();
//     location.getLocation().then(
//       (location) {
//         currentLocation = location;
//       },
//     );
//     GoogleMapController googleMapController = await _controller.future;
//     location.onLocationChanged.listen((newLoc) {
//       currentLocation = newLoc;
//       googleMapController.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(
//           zoom: 13.5,
//           target: LatLng(
//             newLoc.latitude!,
//             newLoc.longitude!,
//           ),
//         ),
//       ));
//       setState(() {});
//     });
//   }
//
//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       StringConstants.googleApiKey,
//       PointLatLng(StringConstants.sourceLocation.latitude,
//           StringConstants.sourceLocation.longitude),
//       PointLatLng(StringConstants.destination.latitude,
//           StringConstants.destination.longitude),
//       travelMode: TravelMode.driving,
//     );
//     debugPrint('my points');
//     print(result.points);
//     if (result.points.isNotEmpty) {
//       result.points.forEach(
//         (PointLatLng point) => polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         ),
//       );
//       setState(() {});
//     } else {
//       debugPrint('error: ${result.errorMessage}');
//     }
//   }
//
//   // void setCustomMarkerIcon(){
//   //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/icons/sourceIcon.png').then((icon) {
//   //   sourceIcon=icon;
//   //   },);
//   //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/icons/destinationIcon.png').then((icon) {
//   //     destinationIcon=icon;
//   //   },);
//   //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/icons/currentLoctionIcon.png').then((icon) {
//   //     currentLocationIcon = icon;
//   //   },);
//   // }
//
//   @override
//   void initState() {
//     // getCurrentLocation();
//     // setCustomMarkerIcon();
//     getPolyPoints();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         // (currentLocation == null)
//         //     ? Center(
//         //         child: Column(
//         //         // crossAxisAlignment: CrossAxisAlignment.center,
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: const [
//         //           CircularProgressIndicator(),
//         //           SizedBox(
//         //             height: 10,
//         //           ),
//         //           Text(
//         //             'Loading...',
//         //             style: TextStyle(
//         //               color: Colors.black54,
//         //               fontSize: 20,
//         //             ),
//         //           )
//         //         ],
//         //       )) :
//         GoogleMap(
//       myLocationButtonEnabled: true,
//       myLocationEnabled: true,
//       tiltGesturesEnabled: true,
//       compassEnabled: true,
//       scrollGesturesEnabled: true,
//       zoomGesturesEnabled: true,
//       initialCameraPosition: CameraPosition(
//         target: LatLng(StringConstants.sourceLocation.latitude,
//             StringConstants.sourceLocation.longitude),
//         // target: LatLng(
//         //     currentLocation!.latitude!, currentLocation!.longitude!),
//         zoom: 13,
//       ),
//       polylines: {
//         Polyline(
//           polylineId: const PolylineId('route'),
//           points: polylineCoordinates,
//           color: StringConstants.primaryColor,
//           width: 6,
//         ),
//       },
//       markers: {
//         // Marker(
//         //     markerId: const MarkerId('currentLocation'),
//         //     position: LatLng(currentLocation!.latitude!,
//         //         currentLocation!.longitude!),
//         //     icon: BitmapDescriptor.defaultMarker),
//         Marker(
//             markerId: const MarkerId('source'),
//             position: StringConstants.sourceLocation,
//             icon: BitmapDescriptor.defaultMarker),
//         Marker(
//           markerId: const MarkerId('destination'),
//           position: StringConstants.destination,
//           icon: BitmapDescriptor.defaultMarker,
//         ),
//       },
//       onMapCreated: (mapController) {
//         _controller.complete(mapController);
//       },
//     );
//   }
//
//   Future<Polyline> _getRoutePolyline(
//       {required LatLng start,
//       required LatLng finish,
//       required Color color,
//       required String id,
//       int width = 6}) async {
//     final polylinePoints = PolylinePoints();
//     final List<LatLng> polylineCoordinates = [];
//
//     final startPoint = PointLatLng(start.latitude, start.longitude);
//     final finishPoint = PointLatLng(finish.latitude, finish.longitude);
//
//     final result = await polylinePoints.getRouteBetweenCoordinates(
//         StringConstants.googleApiKey, startPoint, finishPoint);
//
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         );
//       });
//     }
//     final polyline = Polyline(
//         polylineId: PolylineId(id),
//         color: color,
//         points: polylineCoordinates,
//         width: width);
//     return polyline;
//   }
//
//   Future<Set<Polyline>> _getTwoPolylines() async {
//     const firstPolylineStart = LatLng(49.818453, 24.076606);
//     const firstPolylineFinish = LatLng(49.834409, 24.067875);
//
//     final firstPolyline = await _getRoutePolyline(
//         start: firstPolylineStart,
//         finish: firstPolylineFinish,
//         color: Colors.green,
//         id: 'firstPolyline');
//
//     const secondPolylineStart = LatLng(49.836510, 24.064096);
//     const secondPolylineFinish = LatLng(49.840191, 24.043384);
//     final secondPolyline = await _getRoutePolyline(
//         start: secondPolylineStart,
//         finish: secondPolylineFinish,
//         color: Colors.red,
//         id: 'secondPolyline');
//
//     final Set<Polyline> polylines = {};
//     polylines.add(firstPolyline);
//     polylines.add(secondPolyline);
//     return polylines;
//   }
// }
