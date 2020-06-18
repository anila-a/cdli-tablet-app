import 'package:flutter/material.dart';
import 'package:cdli_tablet_app/services/cdli_data_state.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:cdli_tablet_app/screens/tile_screen.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

class SearchModel extends StatefulWidget {
  @override
  _SearchModelState createState() => _SearchModelState();
}

class _SearchModelState extends State<SearchModel> {

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

  Future<List<cdliDataState>> search(String search) async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(dataState.list.length, (int index) {
      return cdliDataState(list: dataState.list);
    });
  }

  final SearchBarStyle searchBarStyle = new SearchBarStyle();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SearchBar<cdliDataState>(
          textStyle: TextStyle(color: Colors.black, decoration: null),
          onSearch: search,
          //searchBarController: SearchBarController(),
          searchBarStyle: SearchBarStyle(
            backgroundColor: Color.fromRGBO(255, 255, 255, .95),
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
          ),
          hintText: 'Search',
          onItemFound: (cdliDataState dataState, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(dataState.list[index].full_title, style: TextStyle(color: Colors.white, fontSize: 16),),
                subtitle: Text(date(index), style: TextStyle(color: Colors.grey, fontSize: 15),),
                onTap: () {
                  navigateToDetailScreen(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToDetailScreen(int index) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => TileScreen(index)));
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
