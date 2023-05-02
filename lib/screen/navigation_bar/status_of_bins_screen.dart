import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../component/navigator_drawer_widget.dart';
import '../../map_build/constants.dart';
import 'dart:ui' as ui;

class StatusBinsScreen extends StatefulWidget {
  const StatusBinsScreen({Key? key}) : super(key: key);

  @override
  State<StatusBinsScreen> createState() => _StatusBinsScreenState();
}

class _StatusBinsScreenState extends State<StatusBinsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;

  List<String> images = ['assets/icons/1.png', 'assets/icons/redBins.jpg'];

  final List<Marker> _markers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.394211, 75.533006),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'empty',
        snippet: 'Testing',
      ),
    ),
  ];
  final List<LatLng> _latLang = [
    StringConstants.nitjLocation,
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

  final List<String> _nitJPositionName = [
    'Nit Jalandhar'
    'main gate',
    'OAT',
    'nitj main park',
    'cricket ground',
    'Temple',
    'Guest House',
    'DS',
    'Textile',
    'lecture theatre',
    'Bt Canteen',
    'MegaBoys Hostel',
    'Snacker',
    'NitJ Library',
  ];
  

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() async {
    for (int i = 0; i < _markers.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAssets((i % 2 == 0) ? images[0] : images[1], 80);
      _markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: _latLang[i],
          icon: (i != 0)
              ? BitmapDescriptor.fromBytes(markerIcon)
              : BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: _nitJPositionName[i] + i.toString(),
            snippet: 'Dustbins',
          ),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text(
          'Bins Status',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(StringConstants.nitjLocation.latitude,
                StringConstants.nitjLocation.longitude),
            zoom: 17,
          ),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
