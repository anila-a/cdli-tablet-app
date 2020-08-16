import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/menu_dashboard_model.dart';
import 'package:cdli_tablet_app/models/intro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> with AfterLayoutMixin<InitialScreen>{

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('Seen') ?? false);

    if (_seen) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MenuDashboardModel())
      );
    } else {
      await prefs.setBool('Seen', true);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => IntroScreen())
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () {
        _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'cdli tablet',
            style: TextStyle(color: Colors.white, fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.w400,),
          ),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              tooltip: 'Close',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MenuDashboardModel()));
              },
            ),
          ],
        ),
        body: IntroModel(),
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
