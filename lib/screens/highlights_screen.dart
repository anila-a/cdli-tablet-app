import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/highlights_model.dart';

class HighlightsScreen extends StatefulWidget {
  @override
  _HighlightsScreenState createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
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
        backgroundColor: Colors.black,
      ),
      body: HighlightsModel(),
    );
  }
}
