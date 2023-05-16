import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swms/map_build/constants.dart';

// yeh class hai point ki
class Point {
  double latitude;
  double longitude;

  Point(this.latitude, this.longitude);
}

// yeh function points ko arrange kr ke dega shortest order me, starting point lega aur list of points
List<Point> sortPointsInShortestPath(List<Point> points, Point startingPoint) {
  List<Point> sortedPoints = List.from(points);

  // Calculate the distance from the starting point to each point
  sortedPoints.sort((a, b) {
    double distanceA = calculateDistance(startingPoint, a);
    double distanceB = calculateDistance(startingPoint, b);
    return distanceA.compareTo(distanceB);
  });

  // Append the starting point at the end to make it the ending point
  sortedPoints.add(startingPoint);

  return sortedPoints;
}

// yeh function distance calculate krega
double calculateDistance(Point point1, Point point2) {
  double lat1 = point1.latitude;
  double lon1 = point1.longitude;
  double lat2 = point2.latitude;
  double lon2 = point2.longitude;

  const int earthRadius = 6371000; // Radius of the Earth in meters

  double latDistance = radians(lat2 - lat1);
  double lonDistance = radians(lon2 - lon1);

  double a = sin(latDistance / 2) * sin(latDistance / 2) +
      cos(radians(lat1)) * cos(radians(lat2)) * sin(lonDistance / 2) * sin(lonDistance / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;

  return distance;
}

double radians(double degrees) {
  return degrees * pi / 180;
}

// yeh example hai
void main() {
  List<Point> points = [
    Point(37.7749, -122.4194), // San Francisco
    Point(34.0522, -118.2437), // Los Angeles
    Point(40.7128, -74.0060), // New York
    Point(51.5074, -0.1278), // London
    Point(48.8566, 2.3522), // Paris
  ];

  Point startingPoint = Point(37.7749, -122.4194); // San Francisco

  List<Point> sortedPoints = sortPointsInShortestPath(points, startingPoint);

  print('Sorted Points:');
  for (var point in sortedPoints) {
    print('Latitude: ${point.latitude}, Longitude: ${point.longitude}');
  }
}

// Yeh example output hai
// Sorted Points:
// Latitude: 34.0522, Longitude: -118.2437
// Latitude: 40.7128, Longitude: -74.0060
// Latitude: 48.8566, Longitude: 2.3522
// Latitude: 51.5074, Longitude: -0.1278
// Latitude: 37.7749, Longitude: -122.4194


class OrderTrackingPageDemo extends StatefulWidget {
  const OrderTrackingPageDemo({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPageDemo> createState() => _OrderTrackingPageDemoState();
}

class _OrderTrackingPageDemoState extends State<OrderTrackingPageDemo> {
  final Completer<GoogleMapController> _controller=Completer();

  static const LatLng sourceLocation = LatLng(31.39442759772203, 75.53319387453674);
  static const LatLng destination = LatLng(31.397751947313804, 75.53673439032721);

  List<LatLng> polylineCoordinates=[];
  LocationData? currentLocation;

  void getCurrentLocation(){
    Location location = Location();
    location.getLocation().then(
            (location){
      currentLocation=location;
    },);
  }


  void getPolyPoints() async {
    PolylinePoints polylinePoints =PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(StringConstants.googleApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude), PointLatLng(destination.latitude, destination.longitude));

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(
        LatLng(point.latitude, point.longitude),
      ),);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation == null ? Center(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 10,),
        Text("Loading..."),
      ],
    )) :
      GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),zoom: 14.5),
      polylines: {
        Polyline(polylineId: PolylineId("route"),
          points: polylineCoordinates,
          color: StringConstants.primaryColor,
          width: 6,
        ),
        Polyline(
          // Add a new polyline for the current location
          polylineId: PolylineId("currentLocation"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 4,
        ),
      },
      markers: {
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
        ),
        Marker(
          markerId: MarkerId("source"),
          position: sourceLocation,
        ),
        Marker(
          markerId: MarkerId("Destination"),
          position: destination,
        )
      },
    );
  }
}

