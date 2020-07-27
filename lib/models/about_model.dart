import 'package:flutter/material.dart';

class AboutModel extends StatefulWidget {
  @override
  _AboutModelState createState() => _AboutModelState();
}

class _AboutModelState extends State<AboutModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Text('ABOUT', style: TextStyle(color: Colors.grey, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.info_outline, color: Colors.white, size: 22,),
                  SizedBox(width: 10,),
                  Text('Cuneiform Digital Library Initiative', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,)),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 0.28,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('“cdli tablet” is now on Android! Focusing on the cultural '
                          'heritage of ancient Mesopotamia, the app combines text and '
                          'images documenting three millennia of human activity that '
                          'includes the development of trade, mathematics, and astronomy. '
                          'Users will follow the application of the law of an eye for an '
                          'eye by the Old Babylonian king Hammurapi, and will relive the '
                          'exploits of Gilgamesh and Enkidu. Striking images of selected '
                          'cuneiform texts and related artifacts are placed in their '
                          'historical setting with short narratives prepared by experts '
                          'in the languages and archaeology of the ancient Near East, '
                          'but also by college students approaching a distant world with '
                          'fresh eyes.',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'NotoSansJP',
                              fontWeight: FontWeight.w400,)),
                ),
                      ),
                    ),
                      ]),
            ),
    );
  }
}
