import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swms/component/form_widget.dart';
import 'package:swms/utils/dialog.dart';

class InsertData extends StatelessWidget {
  InsertData({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  late String idValue;
  late String capacityValue;
  late String heightValue;
  late String locationValue;
  final dataBaseRef = FirebaseDatabase.instance.ref('Bin');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserting Data'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Inserting Dustbin in Firebase Realtime Database',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      onSaved: (name) {
                        idValue = name!;
                      },
                      labelText: 'Dustbin Identity',
                      hintText: 'Enter Id',
                      prefixIcon: Icon(CupertinoIcons.trash),
                      keyboardType: TextInputType.name),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      onSaved: (capacity) {
                        capacityValue = capacity!;
                      },
                      labelText: 'Capacity',
                      hintText: 'Enter Capacity',
                      prefixIcon: Icon(Icons.height_rounded),
                      keyboardType: TextInputType.number),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      onSaved: (height) {
                        heightValue = height!;
                      },
                      labelText: 'Height',
                      hintText: 'Enter Height',
                      prefixIcon: Icon(Icons.height_rounded),
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      onSaved: (location) {
                        locationValue = location!;
                      },
                      labelText: 'Location',
                      hintText: 'Enter Location',
                      prefixIcon: Icon(CupertinoIcons.location),
                      keyboardType: TextInputType.name),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                        insertData(idValue, capacityValue, heightValue, locationValue);
                        showDialog(context: context, builder: (context)=>buildPopupDialog(context, 'Uploaded!', 'Successfully uploaded'));
                      }
                    },
                    child: const Text('Insert Dustbin'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    minWidth: 300,
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void insertData(
      String number, String capacity, String height, String location) {
    dataBaseRef.push().set({
      'id': number,
      'capcity': capacity,
      'height': height,
      'location': location,
    });
  }
}
