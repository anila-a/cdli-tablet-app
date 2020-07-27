import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cdli_tablet_app/services/cdli_data_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cache_image/cache_image.dart';

class HighlightsModel extends StatefulWidget {
  @override
  _HighlightsModelState createState() => _HighlightsModelState();
}

class _HighlightsModelState extends State<HighlightsModel> {

  static cdliDataState dataState = new cdliDataState();

  @override
  void initState() {
    super.initState();
    getDataFromApi();
  }

  getDataFromApi() async {
    if (!mounted) return;
    await dataState.getDataFromAPI();
    setState(() {
      if (dataState.error) {
        _showError();
      }
    });
  }

  void _retry() {
    Scaffold.of(context).removeCurrentSnackBar();
    dataState.reset();
    setState(() {});
    getDataFromApi();
  }

  void _showError() {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Check your connection and try again.', style: TextStyle(fontFamily: 'NotoSansJP',
        fontWeight: FontWeight.w400,),),
      duration: new Duration(seconds: 3),
      action: new SnackBarAction(
        label: 'Retry',
        textColor: Colors.cyan,
        onPressed: () {
          _retry();
        },
      ),
    ));
  }

  int _current = 0;
  List highlights = ['assets/images/maceheads07-557b025d7a644-5580cb83bce9d.jpg',
                     'assets/images/maceheads07-557b025d7a644-5580cdc26ec0c.jpg',
                     'assets/images/P431605-5508f0a82d6a6-551ebb518e0d9.jpg'];
  List titles = ['Mace heads: 7', 'Mace heads: 6', 'Mace heads: 5'];
  List blurbs = ['A marble mace head from Sippar dated to the reign of Manishtusu of the Old Akkadian period (2340-2200 BC).',
                 'An Old Akkadian (2340-2200 BC) mace head from Ur with a dedicatory inscription; said to be made of aragonite.',
                 'A stone mace head from the Early Babylonian period (2000-1800 BC), after the collapse of the Ur III dynasty in southern Mesopotamia.'];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
              height: 400.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: highlights.map((imgAsset) {
                return Builder(
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Image.asset(
                            imgAsset, fit: BoxFit.fitWidth,
                          //loadingBuilder: progressIndicator(),
                          ),
                      ),
                          SizedBox(
                            height: 30,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(titles[_current], style: TextStyle(color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'NotoSansJP',
                                fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                          SizedBox(
                            height: 10,
                          ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Text(blurbs[_current], style: TextStyle(color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'NotoSansJP',
                                      fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                                  )),
                                ],
                              ),
                            ),
                          ],),
                    );
                  },
                );
          }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(highlights, (index, asset) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(shape: BoxShape.circle,
                color: _current == index ? Colors.white : Colors.grey),
              );
            })),
    ])
      );
  }
}
