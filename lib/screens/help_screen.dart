import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/models/help_model.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
        leading: PlatformIconButton(
          android: (_) => MaterialIconButtonData(icon: Icon(Icons.arrow_back, color: Colors.white,)),
          ios: (_) => CupertinoIconButtonData(icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: HelpModel(),
    );
  }
}
