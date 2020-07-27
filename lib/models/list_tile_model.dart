import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/services/cdli_data_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:cdli_tablet_app/services/cdli_data.dart';
import 'package:cdli_tablet_app/services/db_helper.dart';
import 'package:cache_image/cache_image.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class ListTileModel extends StatefulWidget {
  final title;
  final image;
  final info;
  final thumbnail;
  final short_info;

  ListTileModel(this.title, this.image, this.info, this.thumbnail, this.short_info);

  @override
  State<StatefulWidget> createState() {
    return _ListTileModelState(this.title, this.image, this.info, this.thumbnail, this.short_info);
  }
}

class _ListTileModelState extends State<ListTileModel> {
  String title;
  String image;
  String info;
  String thumbnail;
  String short_info;

  _ListTileModelState(this.title, this.image, this.info, this.thumbnail, this.short_info);

  final cdliDataState dataState = new cdliDataState();
  DatabaseHelper dbHelper = DatabaseHelper();
  cdliData data;

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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: dataState.list.length.compareTo(0),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: <Widget>[
            new SizedBox.expand(
                child: PhotoView(
                  imageProvider: CacheImage(image,
                  ),
                  loadingBuilder: (context, progress) => Center(
                      child : new Container(
                          child: PlatformCircularProgressIndicator(
                            android: (_) => MaterialProgressIndicatorData(),
                            ios: (_) => CupertinoProgressIndicatorData(radius: 25),
                          )
                      )),
                )
            ),
            new DraggableScrollableSheet(
              initialChildSize: 0.27,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                    controller: scrollController,
                    child: new Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height),
                        color: Colors.black54,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Title and Icons
                            new Container(
                                padding: EdgeInsets.only(
                                    left: 32, right: 32, top: 32),
                                child: new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Expanded(
                                        child: new Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Text(title,
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: 'NotoSansJP',
                                                  fontWeight: FontWeight.w400,)),
                                            new SizedBox(
                                              height: 20,
                                            ),
                                            // Spacing
                                            new Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                new IconButton(
                                                  icon: Icon(
                                                    Icons.collections,
                                                    color: Colors.grey,
                                                    size: 24,
                                                  ),
                                                  tooltip: 'Save to collection',
                                                  onPressed: () {
                                                    //showSnackBar(context); // Call function
                                                    save();
                                                  },
                                                ),
                                                new SizedBox(
                                                  width: 33,
                                                ),
                                                new IconButton(
                                                  icon: Icon(
                                                    Icons.share,
                                                    color: Colors.grey,
                                                    size: 24,
                                                  ),
                                                  tooltip: 'Share',
                                                  onPressed: () {
                                                    share(thumbnail, short_info);
                                                  },
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                )),
                            // Text
                            new Container(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32),
                              child: new Column(
                                children: <Widget>[
                                  new SizedBox(
                                    height: 20,
                                  ),
                                  new Text(
                                    'swipe up',
                                    style: TextStyle(
                                        color: Colors.cyan, fontSize: 14, fontFamily: 'NotoSansJP',
                                      fontWeight: FontWeight.w400,),
                                  ),
                                  new SizedBox(
                                    height: 20,
                                  ),
                                  new Html(
                                    data: info,
                                    defaultTextStyle: TextStyle(
                                        color: Colors.white, fontFamily: 'NotoSansJP', fontSize: 15),
                                    onLinkTap: (url) async {
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                  ),
                                  new SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )));
              },
            ),
          ],
        );
      },);
  }

  void share(String thumbnail, String short_info) async {
    var request = await HttpClient().getUrl(Uri.parse(thumbnail));
    var response = await request.close();

    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('cdli tablet', 'image.jpg', bytes, 'image/jpg',
        text: 'I saw this entry on the app "cdli tablet" and wanted to share it with you: \n\n'
            + '"' + short_info + '"' + "\n\n");
  }

  void showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text('Saved to collection', style: TextStyle(fontFamily: 'NotoSansJP',
          fontWeight: FontWeight.w400,)),
        duration: const Duration(seconds: 2),
        action: new SnackBarAction(
            label: "Undo",
            textColor: Colors.cyan,
            onPressed: () {
              // Undo change
            })));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void save() async {
    moveToLastScreen();
    int result;

    if(data.idDB == null) {
      result = await dbHelper.insertData(data);
    }

    if (result != 0) {
      showSnackBar(context);
    } else {
      showSnackBar(context);
    }
    moveToLastScreen();
  }
}
