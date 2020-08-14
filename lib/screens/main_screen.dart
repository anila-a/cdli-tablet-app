import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/main_model.dart';
import 'package:cdli_tablet_app/screens/search_screen.dart';
import 'package:cdli_tablet_app/screens/about_screen.dart';
import 'package:cdli_tablet_app/screens/help_screen.dart';
import 'package:cdli_tablet_app/screens/grid_screen.dart';
import 'package:cdli_tablet_app/screens/list_screen.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            'cdli tablet',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              tooltip: 'Search',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ],
        ),
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0)),
          child: Drawer(
            child: Container(
              color: Color.fromRGBO(18, 18, 18, 1),
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/ic_launcher.png'),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 25,
                          //height: 45,
                        ),
                        Image.asset(
                          'assets/images/ic_cdlilogo.png',
                          //Image.asset('assets/images/logo-no-text.jpg',
                          scale: 8.5,
                          alignment: Alignment.centerLeft,
                        ),
                      ]),
                    ),
                  ),
                  //Divider(color: Colors.white,),
                  ListTile(
                    //leading: Icon(Icons.grid_on, color: Colors.white, size: 22,),
                    title: Text(
                      'APP',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.grid_on,
                        color: Colors.white,
                        size: 22,
                      ),
                      title: Text(
                        'Grid Layout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GridScreen()),
                        );
                      }),
                  ListTile(
                      leading: Icon(
                        Icons.sort_by_alpha,
                        color: Colors.white,
                        size: 22,
                      ),
                      title: Text(
                        'List Layout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListScreen()),
                        );
                      }),
                  Divider(
                    color: Colors.white,
                    thickness: 0.28,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                      title: Text(
                        'About',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()),
                        );
                      }),
                  ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                      title: Text(
                        'Help and Feedback',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpScreen()),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
        body: MainModel(),
      ),
    );
  }

  Future<bool> _onBackPressed() {
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
