import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/tile_model.dart';

class TileScreen extends StatefulWidget {
  final position;

  TileScreen(this.position);

  @override
  State<StatefulWidget> createState() {
    return _TileScreenState(this.position);
  }
}

class _TileScreenState extends State<TileScreen> {
  int position;

  _TileScreenState(this.position);

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
      ),
      body: TileModel(position),);
  }
}
