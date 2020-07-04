import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/main_model.dart';
import 'package:cdli_tablet_app/screens/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'cdli tablet',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          /*IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            tooltip: 'Search',
            onPressed: () {
              // something
            },
          ),*/
          IconButton(
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            tooltip: 'Dashboard',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
            },
          ),
        ],
      ),
      body: MainModel(),
    );
  }
}
