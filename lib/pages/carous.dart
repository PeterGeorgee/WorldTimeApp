import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/world_time.dart';

class sliderr extends StatefulWidget {
  const sliderr({Key? key}) : super(key: key);

  @override
  _sliderrState createState() => _sliderrState();
}

class _sliderrState extends State<sliderr> {
  Map data={};
  @override
  Widget build(BuildContext context) {
    data=data.isNotEmpty?data:ModalRoute.of(context)!.settings.arguments as Map;
    List<String>photoss=data['phottoo'];
    String coun=data['country'];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text('$coun',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: CarouselSlider.builder(itemCount: 3, itemBuilder: (context,index,realIndex){
          final myImage=photoss[index];
          return buildImage(myImage,index);
        }, options: CarouselOptions(
          height: 250,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
        )),
      ),
    );
  }
  Widget buildImage(String myImage,int index)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
    color: Colors.grey[200],
    child: Image.asset(myImage,fit: BoxFit.cover,),
  );
}
