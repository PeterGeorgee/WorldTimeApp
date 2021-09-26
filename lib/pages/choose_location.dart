import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locationsOnSearch=[];

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png', country: 'England',photos: ['assets/uk.png',
        'assets/uk 1.jpg',
        'assets/uk 2.jpg']),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png', country: 'Greece',photos: ['assets/greece.png',
      'assets/greece 1.jpg',
      'assets/greece 2.jpg']),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png', country: 'Egypt',photos: ['assets/egypt.png',
      'assets/egypt 1.jpg',
      'assets/egypt 2.jpg']),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png', country: 'Kenya',photos: [
      'assets/kenya.png',
      'assets/kenya 1.jpg',
      'assets/kenya 2.jpg']),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png', country: 'USA',photos: [
      'assets/usa.png',
      'assets/usa 1.jpg',
      'assets/usa 2.jpg']),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png', country: 'USA',photos: [
      'assets/usa.png',
      'assets/usa 1.jpg',
      'assets/usa 2.jpg']),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png', country: 'South Korea',photos: [
      'assets/south_korea.png',
      'assets/south korea 1.jpg',
      'assets/south korea 2.jpg']),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png', country: 'Indonesia',photos: [
      'assets/indonesia.png',
      'assets/indonesia 1.jpg',
      'assets/indonesia 2.jpg']),
  ];

  void updateTime(index) async{
    WorldTime instance=_textEditingController!.text.isNotEmpty?locationsOnSearch[index]:locations[index];
    await instance.getTime();
    Navigator.pop(context,{
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime':instance.isDaytime,
      'country':instance.country,
    });
  }

  void openPhoto(index) async{
    WorldTime instance=_textEditingController!.text.isNotEmpty?locationsOnSearch[index]:locations[index];
    await instance.getTime();
    Navigator.pushNamed(context,'/caro',arguments: {
      'flag':instance.flag,
      'phottoo':instance.photos,
       'country':instance.country,
    });
  }


  TextEditingController? _textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(color: Colors.blue[100],
          borderRadius: BorderRadius.circular(30)),
          child: TextField(
            onChanged: (value){
              setState(() {
                locationsOnSearch=locations.where((element) => element.location.toLowerCase().startsWith(value)).toList();
              });
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search...'
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            locationsOnSearch.clear();
            _textEditingController!.clear();
            setState(() {
              _textEditingController!.text='';
            });
          },
              child: Icon(Icons.close,color: Colors.black,))
        ],
      ),
      body: _textEditingController!.text.isNotEmpty&&locationsOnSearch.isEmpty?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off,size: 90.0,),
              Text(
                'No results found',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ):
      ListView.builder(
        itemCount: _textEditingController!.text.isNotEmpty?locationsOnSearch.length:locations.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  showDialog(
                      //barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context)=>AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        title: const Text('Where to?'),
                        content: const Text('Choose your page.'),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                                openPhoto(index);},
                                child: const Text(
                                  'Photo',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                                updateTime(index);},
                                child: const Text('Home Page',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  );
                },
                title: Text(
                    _textEditingController!.text.isNotEmpty?locationsOnSearch[index].location:locations[index].location
                ),
                subtitle: Text(_textEditingController!.text.isNotEmpty?locationsOnSearch[index].country:locations[index].country),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${_textEditingController!.text.isNotEmpty?locationsOnSearch[index].flag:locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
