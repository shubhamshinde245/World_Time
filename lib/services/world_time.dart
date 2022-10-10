import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name;
  String time = ''; // time in location;
  String flag; // url to asset
  String url; //location
  bool isDayTime = true; // true or false id daytime or not

  WorldTime({required this.url, required this.location, required this.flag});

  Future<void> getTime() async {
    try {

      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // DateTime object
      DateTime now = DateTime.parse(datetime);

      now = now.add(Duration(hours: int.parse(offset)));

      // setting time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch (e) {
      time = 'Could not load data';
      }
    }
  }

