import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cdli_tablet_app/screens/main_screen.dart';
import 'package:cdli_tablet_app/screens/highlights_screen.dart';

class IntroModel extends StatefulWidget {
  @override
  _IntroModelState createState() => _IntroModelState();
}

class _IntroModelState extends State<IntroModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                          Text('Welcome to cdli tablet', style: TextStyle(
                          color: Colors.white, fontSize: 23, fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                    ],),),],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(color: Colors.white, thickness: 0.28,),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                  child: Container(
                    child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                      'sed do eiusmod tempor incididunt ut labore et dolore magna '
                      'aliqua. Ut enim ad minim veniam, quis nostrud exercitation '
                      'ullamco laboris nisi ut aliquip ex ea commodo consequat.', style: TextStyle(
                    color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                ),),],
              ),
              SizedBox(
                height: 35,
              ),
              ButtonTheme(
                minWidth: 330.0,
                height: 50.0,
                child: RaisedButton(
                  color: Color.fromRGBO(18, 18, 18, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HighlightsScreen())
                    );
                  },
                  child: Text('View highlights', style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,), textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              ButtonTheme(
                minWidth: 330.0,
                height: 50.0,
                child: RaisedButton(
                  color: Color.fromRGBO(18, 18, 18, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainScreen())
                    );
                  },
                  child: Text('Continue', style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
