import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cdli_tablet_app/services/cdli_data_state.dart';
import 'package:cdli_tablet_app/screens/tile_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:cdli_tablet_app/services/data.dart';
import 'package:cdli_tablet_app/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class CollectionModel extends StatefulWidget {
  @override
  _CollectionModelState createState() => _CollectionModelState();
}

class _CollectionModelState extends State<CollectionModel> {

  /*DatabaseHelper databaseHelper = DatabaseHelper();
  List<Data> dataList;
  int cnt = 0;*/

  @override
  Widget build(BuildContext context) {

    /*if (dataList == null) {
      dataList = List<Data>();
      update();
    }*/

    return new ListView.builder(
      //itemCount: cnt,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blue,
          child: ListTile(
            //title: Text(this.dataList[index].fullTitleDB, style: TextStyle(color: Colors.white, fontFamily: 'Belleza', fontSize: 16),),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 55,
                minWidth: 55,
                maxHeight: 75,
                maxWidth: 75,
              ),
              /*child: Image.network(
                this.dataList[index].urlDB,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, progress) {
                  return progress == null ? child : new Center(
                      child: PlatformCircularProgressIndicator(
                        android: (_) => MaterialProgressIndicatorData(),
                        ios: (_) => CupertinoProgressIndicatorData(radius: 25),
                      )
                  );
                },
              ),*/
            ),
            //subtitle: Text(this.dataList[index].dateDB, style: TextStyle(color: Colors.grey, fontFamily: 'Belleza', fontSize: 15),),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.white,),
              onTap: () {
                //_delete(context, dataList[index]);
              },
            ),
            onTap: () {
              // navigate to tile screen
            },
          ),
    );
  });}

  /*void _delete(BuildContext context, Data data) async {
    int result = await databaseHelper.deleteData(data.id);

    if (result != 0) {
      showSnackBar(context);
      update();
    }
  }

  void update() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Data>> dataListFuture = databaseHelper.getDataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList;
          this.cnt = dataList.length;
        });
      });
    });
  }

  void showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text('Deleted successfully.'),
        duration: const Duration(seconds: 2),
        action: new SnackBarAction(
            label: "Undo",
            textColor: Colors.cyan,
            onPressed: () {
              // Undo change
            })));
  }*/
}
