import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/grid_model.dart';
import 'package:cdli_tablet_app/models/list_model.dart';
//import 'package:cdli_tablet_app/models/collection_model.dart';
import 'package:cdli_tablet_app/screens/search_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
            leading: PlatformIconButton(
              android: (_) => MaterialIconButtonData(icon: Icon(Icons.arrow_back, color: Colors.white,)),
              ios: (_) => CupertinoIconButtonData(icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  //Navigator.push(context,
                      //MaterialPageRoute(builder: (context) => DashboardScreen()));
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
            ListModel(),
            //CollectionModel(),
            IconButton(icon: Icon(Icons.collections, color: Colors.white,), onPressed: () {},),
          ]),
        ));
  }
}
