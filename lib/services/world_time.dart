import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  late String time;
  String flag;
  String url;
  late bool isDaytime;
  String country;
  List<String> photos;


  WorldTime({required this.location, required this.flag, required this.url, required this.country,required this.photos});

  Future<void> getTime() async{
    try {
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime=now.hour>6 && now.hour<20?true:false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught Error: $e');
      time='could not get time data';
    }
  }
}