import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/routes/routes.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'cdli tablet',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        routes: routes);
  }
}
