import 'dart:convert';

class cdliData {

  final String date;
  final String thumbnail_url; final String url;
  final String blurb_title; final String theme; final String blurb;
  final String full_title; final String full_info;

  cdliData({this.date, this.thumbnail_url, this.url, this.blurb_title, this.theme, this.blurb, this.full_title, this.full_info});

  static List<cdliData> fromJsonArray(String covariant) {

    List data = json.decode(covariant);
    List<cdliData> result = [];

    for (var i = 0; i < data.length; i++) {
      result.add(
          new cdliData(
              date: data[i]['date'],
              thumbnail_url: data[i]['thumbnail-url'],
              url: data[i]['url'],
              blurb_title: data[i]['blurb-title'],
              theme: data[i]['theme'],
              blurb: data[i]['blurb'],
              full_title: data[i]['full-title'],
              full_info: data[i]['full-info'])
      );}
    return result;
  }

  getTitle() {
    return this.full_title;
  }

}
