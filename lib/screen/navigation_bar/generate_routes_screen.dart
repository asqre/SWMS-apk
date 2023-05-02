import 'package:flutter/material.dart';
import 'package:swms/component/form_widget.dart';
import 'package:swms/map_build/order_tracking_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/navigator_drawer_widget.dart';

class GenerateRoutesScreen extends StatelessWidget {
   GenerateRoutesScreen({Key? key}) : super(key: key);
  final _formKey =GlobalKey<FormState>();
   String? sourceInput;
   String? destinationInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('Routes',style: TextStyle(color: Colors.white),),
        // backgroundColor: Colors.black,
      ),
      // body: OrderTrackPage(),
      body: PolylineScreen(),
      // OrderTrackPage()
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 50,right: 20,left: 20),
      //     child: Form(
      //       key: _formKey,
      //       child: Container(
      //         child: Column(
      //           children: [
      //             TextWidget(onSaved: (source){
      //               sourceInput = source!;
      //               }, labelText: 'Source', hintText: 'your location', prefixIcon: Icon(Icons.location_searching), keyboardType: TextInputType.streetAddress),
      //             SizedBox(height: 20,),
      //             TextWidget(onSaved: (destination){destinationInput =destination!;}, labelText: 'Destination', hintText: 'choose destination', prefixIcon: Icon(Icons.location_on), keyboardType: TextInputType.streetAddress),
      //             SizedBox(height: 20,),
      //             ElevatedButton(onPressed: () async {
      //               if (_formKey.currentState != null &&
      //                   _formKey.currentState!.validate()){
      //                 _formKey.currentState!.save();
      //                 FocusScope.of(context).unfocus();
      //                 final googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$sourceInput,$destinationInput");
      //                 if(await canLaunchUrl(googleMapsUrl)){
      //                   await launchUrl(googleMapsUrl);
      //                 }else{
      //                   throw "couldn't launch: $googleMapsUrl";
      //                 }
      //               }
      //             }, child: Text('Get Routes'))
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
