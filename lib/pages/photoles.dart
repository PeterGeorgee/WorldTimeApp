import 'package:flutter/material.dart';

class photostatless extends StatelessWidget {
  photostatless({Key? key}) : super(key: key);

  Map data={};
  @override
  Widget build(BuildContext context) {
    data=data.isNotEmpty?data:ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          title: Text('${data['country']}'),
        ),
        body: SafeArea(
          child:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/${data['flag']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
    );
  }
}
