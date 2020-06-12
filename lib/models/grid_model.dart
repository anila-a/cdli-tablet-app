import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/services/cdli_data_state.dart';
import 'package:cdli_tablet_app/screens/tile_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class GridModel extends StatefulWidget {
  @override
  _GridModelState createState() => _GridModelState();
}

class _GridModelState extends State<GridModel> {

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
    final orientation = MediaQuery.of(context).orientation;
    return new GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:
        (orientation == Orientation.portrait) ? 2 : 3),
        itemCount: dataState.list.length,
        itemBuilder: (BuildContext context, int index) {
          int position = index;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: new GridTile(
                  child: Image.network(
                    dataState.list[index].url,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, progress) {
                      return progress == null ? child : new Center(
                          child: PlatformCircularProgressIndicator(
                            android: (_) => MaterialProgressIndicatorData(),
                            ios: (_) => CupertinoProgressIndicatorData(radius: 25),
                          )
                      );
                    },
                  ),
                  footer: new Container(
                      color: Colors.black54,
                      child: ListTile(
                        leading: Text(
                          date(index),
                          style: TextStyle(color: Colors.white, fontFamily: 'Belleza', fontSize: 16),
                        ),
                        onTap: () {
                          navigateToDetailScreen(position);
                        },
                      )
                  )
              ),
              color: Colors.black,
            ),
          );
        });
  }

  void navigateToDetailScreen(int position) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => TileScreen(position)));
  }

  date(int index) {
    String m;

    var day = DateTime.parse(dataState.list[index].date).day;
    var month = DateTime.parse(dataState.list[index].date).month;
    var year = DateTime.parse(dataState.list[index].date).year;

    switch(month) {
      case 1: {m = 'January';}
      break;
      case 2: {m = 'February';}
      break;
      case 3: {m = 'March';}
      break;
      case 4: {m = 'April';}
      break;
      case 5: {m = 'May';}
      break;
      case 6: {m = 'June';}
      break;
      case 7: {m = 'July';}
      break;
      case 8: {m = 'August';}
      break;
      case 9: {m = 'September';}
      break;
      case 10: {m = 'October';}
      break;
      case 11: {m = 'November';}
      break;
      case 12: {m = 'December';}
      break;
      default: {m = 'January';}
      break;
    }

    return m + " " + day.toString() + ", " + year.toString();
  }
}
