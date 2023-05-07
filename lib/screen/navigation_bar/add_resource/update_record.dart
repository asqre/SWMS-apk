import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swms/common_functions/string_validator.dart';
import 'package:swms/component/form_widget.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.dustbinKey}) : super(key: key);

  final String dustbinKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final heightController = TextEditingController();
  DatabaseReference? dbRef;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.ref().child('Bin');
    // TODO: implement initState
    super.initState();
    getHeightData();
  }

  void getHeightData() async{
    DataSnapshot snapshot = await dbRef!.child(widget.dustbinKey).get();
    Map dustbin = snapshot.value as Map;
    heightController.text = dustbin['height'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 50,),
              const Text('Updating data in Firebase RealTime Database',style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 24),textAlign: TextAlign.center,),
              const SizedBox(height: 30,),
              // TextWidget(onSaved: (){}, labelText: 'Height', hintText: 'enter height manually', prefixIcon: Icon(Icons.height), keyboardType: TextInputType.number,validator: checkHeightEmpty,),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Height',
                    hintText: 'enter height manually',
                  ),
                  validator: checkHeightEmpty,
                ),
              ),
              const SizedBox( height:  30,),
              MaterialButton(
                  onPressed: (){
                if(_formKey.currentState!= null && _formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  Map<String, String> dustbin = {
                    'height' : heightController.text,
                  };
                  dbRef!.child(widget.dustbinKey).update(dustbin).then((value) => Navigator.pop(context));
                  _formKey.currentState!.reset();
                }
              },child:  const Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
