import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for the UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  bool isDayTime = true; // is day time true or false

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {
      // make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      late String datetime = data['isDayTime'];
      late String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('caught error: $e');
      time = 'could not fetch time';
    }
  }
}