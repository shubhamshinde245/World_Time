import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)!.settings.arguments as Map;
    // print(data);

    // set background
    String bgImage = data['isDayTime'] ? 'day.jpeg': 'night.jpeg';
    Color? bgColor = data['isDayTime'] ? Colors.lightBlueAccent[400] : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Column(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag']
                        };
                      });
                    },
                    icon : const Icon(Icons.edit_location),
                    label: const Text(
                        'Edit Location'
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                    data['location'],
                    style: const TextStyle(
                      fontSize: 30.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    )
                    )
                  ]
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                      data['time'],
                      style: const TextStyle(
                      fontSize: 60.0,
                          color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
