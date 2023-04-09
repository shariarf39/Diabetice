import 'package:flutter/material.dart';

class INfo extends StatelessWidget {
  const INfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Info'),backgroundColor: Colors.green,),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text('This App will give you a soft reminder on the 7 different'
                      ' components of diabetes selt management includes'
                      ' diet, drug, physical exercise, follow-up visit'
                      ', blood glucose testing, risk behaviors and foot care',
                  style: TextStyle(fontSize: 15,color: Colors.black),
                  ),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}
