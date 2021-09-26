import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untitled/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setupWorldTime() async{
    WorldTime instance=WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin', country: 'Germany',photos: [
      'assets/germany.png',
      'assets/germany 1.jpg',
      'assets/germany 2.jpg']);
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime':instance.isDaytime,
      'country':instance.country,
    });

  }
  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.fromLTRB(0, 250.0, 0, 0),
          child: Container(
            child:Column(
          children: <Widget>[
            Text(
              'WorldTime App is Starting!',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 19.0,),
            Center(
              child: SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),

          ],
            ),
          ),
        ),
      ),
    );
  }
}
