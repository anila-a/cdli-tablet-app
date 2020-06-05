import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/grid_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              'cdli tablet',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            //automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                tooltip: 'Search',
                onPressed: () {
                  // do something
                },
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 16),
              tabs: <Widget>[
                Tab(
                  text: 'Grid',
                ),
                Tab(
                  text: 'A-Z',
                ),
                Tab(
                  text: 'Collection',
                ),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            GridModel(),
            Icon(Icons.reorder, color: Colors.white),
            Icon(Icons.collections, color: Colors.white),
          ]),
        ));
  }
}
