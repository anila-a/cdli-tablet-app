import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/main_model.dart';
import 'package:cdli_tablet_app/screens/search_screen.dart';
import 'package:cdli_tablet_app/screens/about_screen.dart';
import 'package:cdli_tablet_app/screens/help_screen.dart';
import 'package:cdli_tablet_app/screens/grid_screen.dart';
import 'package:cdli_tablet_app/screens/list_screen.dart';
import 'package:cdli_tablet_app/screens/collection_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color drawerColor = const Color.fromRGBO(0, 0, 0, 1); // 32, or 7
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          'cdli tablet',
          style: TextStyle(color: Colors.white, fontFamily: 'NotoSansJP',
            fontWeight: FontWeight.w400,),
        ),
        backgroundColor: drawerColor,
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
          /*IconButton(
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            tooltip: 'Dashboard',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
            },
          ),*/
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: drawerColor,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/ic_launcher.png'),
                ),),
                child: Container(
                  alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                        Image.asset('assets/images/ic_cdlilogo.png',
                        scale: 8.5,
                        alignment: Alignment.centerLeft,
                      ),]
                    ),

                ),),

              //Divider(color: Colors.white,),
              ListTile(
                  //leading: Icon(Icons.grid_on, color: Colors.white, size: 22,),
                  title: Text('CDLI APP', style: TextStyle(color: Colors.grey, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,),),
              ),
              ListTile(
                leading: Icon(Icons.grid_on, color: Colors.white, size: 22,),
                title: Text('Grid view', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w400,),),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GridScreen()),
                  );
                }
              ),
              ListTile(
                  leading: Icon(Icons.sort_by_alpha, color: Colors.white, size: 22,),
                  title: Text('List view', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListScreen()),
                    );
                  }
              ),
              ListTile(
                  leading: Icon(Icons.collections, color: Colors.white, size: 22,),
                  title: Text('Collection', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CollectionScreen()),
                    );
                  }
              ),
              Divider(color: Colors.white, thickness: 0.28,),
              ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.white, size: 22,),
                  title: Text('About', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,),),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutScreen()),
                        );
                  }
              ),
              ListTile(
                  leading: Icon(Icons.help_outline, color: Colors.white, size: 22,),
                  title: Text('Help and feedback', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpScreen()),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
      body: MainModel(),
    );
  }
}

