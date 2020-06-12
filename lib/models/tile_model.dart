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
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';

class TileModel extends StatefulWidget {
  final position;

  TileModel(this.position);

  @override
  State<StatefulWidget> createState() {
    return _TileModelState(this.position);
  }
}

class _TileModelState extends State<TileModel> {
  int position;

  _TileModelState(this.position);

  final cdliDataState dataState = new cdliDataState();

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
      content: new Text('Check your connection and try again.'),
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
                  imageProvider: NetworkImage(dataState.list[position].url,
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
              initialChildSize: 0.25,
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
                                            new Text(
                                                dataState
                                                    .list[position].blurb_title,
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold)),
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
                                                    showSnackBar(context); // Call function
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
                                                    share(position);
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
                                        color: Colors.cyan, fontSize: 14),
                                  ),
                                  new SizedBox(
                                    height: 20,
                                  ),
                                  new Html(
                                    data: dataState.list[index].full_info,
                                    defaultTextStyle: TextStyle(
                                        color: Colors.white, fontFamily: 'Belleza', fontSize: 17),
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

  void share(int index) async {
    var request = await HttpClient().getUrl(Uri.parse(dataState.list[index].thumbnail_url));
    var response = await request.close();

    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('cdli tablet', 'image.jpg', bytes, 'image/jpg',
        text: 'I saw this entry on the app "cdli tablet" and wanted to share it with you: \n\n'
            + '"' + dataState.list[index].blurb + '"' + "\n\n");
  }

  void showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text('Saved to collection'),
        duration: const Duration(seconds: 2),
        action: new SnackBarAction(
            label: "Undo",
            textColor: Colors.cyan,
            onPressed: () {
              // Undo change
            })));
  }
}
