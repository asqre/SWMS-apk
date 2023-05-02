import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swms/common_functions/string_validator.dart';
import 'package:swms/component/rating_dialog_widget.dart';
import 'package:swms/utils/dialog.dart';
import 'package:swms/utils/string_constant.dart';


class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text('Help',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        // backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            ListTile(onTap: ()async {
              LaunchWebURL(StringConstant.telegramURL);
              },trailing: FaIcon(FontAwesomeIcons.telegram,color: Colors.blue,), leading: Text('Join Our Community',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),
            ListTile(onTap: (){
              showDialog(context: context, builder: (BuildContext context) => buildPopupDialog(context, StringConstant.whatsNewTitle, StringConstant.whatNewSubtitle));
            }, leading: Text("What's New",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),
            ListTile(onTap: (){
              LaunchApplicationURL(StringConstant.featuresURL);
            }, leading: Text('Features',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),
            ListTile(onTap: (){
              LaunchApplicationURL(StringConstant.FAQURl);
            }, leading: Text('Frequently asked questions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),
            ListTile(onTap: (){
              showDialog(context: context, builder: (context)=> buildPopupDialog(context, 'Updates!', 'App is up to date'));
            }, leading: Text('Check for updates',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),
            ListTile(onTap: (){
                showDialog(context: context, builder: (context) => RatingDialog());
            }, leading: Text('Rate us',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),
            ListTile(onTap: (){
              LaunchApplicationURL(StringConstant.aboutURL);
            }, leading: Text('About',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}


