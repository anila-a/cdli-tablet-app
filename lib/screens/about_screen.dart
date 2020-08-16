import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/about_model.dart';
import 'package:cdli_tablet_app/routes/menu.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatelessWidget with NavigationState {
  final Function onMenuTap;
  const AboutScreen({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'cdli tablet',
            style: TextStyle(color: Colors.white, fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.w400,),
          ),
          backgroundColor: Colors.black,
          leading: InkWell(

            child: Icon(Icons.menu, color: Colors.white),
            onTap: onMenuTap,
          ),
        ),
        body: AboutModel(),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('cdli tablet', style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'NotoSansJP',
            fontWeight: FontWeight.w400,
          ),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to exit?', style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w400,
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes', style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 15,
                fontFamily: 'NotoSansJP',
                fontWeight: FontWeight.w400,
              ),),
              onPressed: () {
                //SystemNavigator.pop();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
            FlatButton(
              child: Text('No', style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 15,
                fontFamily: 'NotoSansJP',
                fontWeight: FontWeight.w400,
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
