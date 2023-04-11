import 'package:flutter/material.dart';

class Developer extends StatelessWidget {
  const Developer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Developer Info'),backgroundColor: Colors.green,),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [


              Container(
                alignment: Alignment.topLeft,
                child: Text('Concept Developer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5,),
              Container(
                child: Text('Dr. Bilkis Banu\nNorthern University Bangladesh'),
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Mobile Application Developer',style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5,),
              Container(
                child: Text('Md Fahim Shariar\nComputer Science And Engineering(CSE)\n'
                    'Northern University Bangladesh'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
