import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/screens/main_screen.dart';
import 'package:cdli_tablet_app/models/intro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
          MaterialPageRoute(builder: (context) => MainScreen())
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
      /*body: Center(
        child: PlatformCircularProgressIndicator(
          android: (_) => MaterialProgressIndicatorData(),
          ios: (_) => CupertinoProgressIndicatorData(radius: 25),
        ),
      ),*/
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: new IconThemeData(color: Colors.white),
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
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
          ),
        ],
      ),
      body: IntroModel(),
    );
  }
}

