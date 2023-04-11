import 'dart:math';


import 'package:diabetes_self_care_new/activitys/figment_ac.dart';
import 'package:diabetes_self_care_new/activitys/pages/avoid_using_tobaco/database_tob.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';



const List<Widget> fruits = <Widget>[
  Text('Once a Day'),
  Text('2 Times a Day'),
  Text('3 Times a Day'),
  Text('4 Times a Day'),
  Text('5 Times a Day'),
];
const List<Widget> alerttype = <Widget>[
  Text('Notification'),
  Text('Alarm'),

];

class Tob_select extends StatefulWidget {

  @override
  State<Tob_select> createState() => _Medi_selectState();
}

class _Medi_selectState extends State<Tob_select> {
  //





  //

  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper_tob.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }































  //final selectTime = "Select Time (Click here)";

  static const String _title = 'ToggleButtons Sample';
  final List<bool> _selectedFruits = <bool>[true, false, false,false,false];
  final List<bool> _alerttype = <bool>[false, true];
  final List<bool> _selectedWeather = <bool>[false, false, true];
  bool vertical = false;

  String dropdownValue = 'One';

  List <String> spinnerItems = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ] ;


  TimeOfDay _timeOfDay = TimeOfDay.now();
  TimeOfDay _timeOfDay1 = TimeOfDay.now();
  TimeOfDay _timeOfDay2 = TimeOfDay.now();
  TimeOfDay _timeOfDay3 = TimeOfDay.now();
  TimeOfDay _timeOfDay4 = TimeOfDay.now();
  TimeOfDay _timeOfDays = TimeOfDay.now();
  var time = DateTime.now();

  //
  bool selectshow = true;
  bool selecttime1 = true;
  bool selecttime2 = true;
  bool selecttime3 = true;
  bool selecttime4 = true;

  bool selectshow1 = false;
  bool selectshow2 = false;
  bool selectshow3 = false;
  bool selectshow4 = false;
  bool hide = false;
  bool set_label= false;

  bool b= false;
  bool b1= false;
  bool b2= false;
  bool b3= false;
  bool b4= false;

  String select =  "Select Time (Click here)";
  String select1 = "Select Time (Click here)";
  String select2 = "Select Time (Click here)";
  String select3 = "Select Time (Click here)";
  String select4 = "Select Time (Click here)";






  @override

  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    void k () async{
      if (id == null) {
        await _addItem();
      }

      if (id != null) {
        await _updateItem(id);
      }

      // Clear the text fields
      _titleController.text = '';
      _descriptionController.text = '';

      // Close the bottom sheet
      Navigator.of(context).pop();
    }

    child: Text(id == null ? 'Create New' : 'Update');
  }

  void al1(){
    FlutterAlarmClock.createAlarm(10,57,title: _titleController.text,);
  }




// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper_tob.createItem(
        _titleController.text, _timeOfDay.toString()

    );
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper_tob.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper_tob.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Add Tobacco"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  BashboardOfFragment()),
                );
              },
            )
          ],
          backgroundColor: Colors.green,),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        labelText: "Tobacco Name",
                        hintText: "Tobacco Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                            )

                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("From when*", style: TextStyle(color: Colors.blue),),
                const SizedBox(height: 5,),
                Text(_timeOfDays.hour.toString() + " : " + _timeOfDays.minute.toString()
                  , style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text("How many times in a day",textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.green),)
                ),
                const SizedBox(height: 5,),
                ///////////////
                const Text("Quantity", style: TextStyle(color: Colors.green),),

                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleButtons(

                    direction: vertical ? Axis.vertical : Axis.horizontal,

                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedFruits.length; i++) {
                          _selectedFruits[i] = i == index;


                        }

                        if(_selectedFruits[0]== true){
                          selectshow1=false;
                          selectshow2=false;
                          selectshow4=false;
                          selectshow3=false;
                          ///
                          b = false;
                          b1 = false;
                          b2 = false;
                          b3 = false;
                          b4 = false;
                          //
                          select =  "Select Time (Click here)";
                          select1 = "Select Time (Click here)";
                          select2 = "Select Time (Click here)";
                          select3 = "Select Time (Click here)";
                          select4 = "Select Time (Click here)";
                        }
                        if(_selectedFruits[1]== true){
                          selectshow1= true;
                          selectshow2=false;
                          selectshow3=false;
                          selectshow4=false;
                          ///
                          b = false;
                          b1 = false;
                          b2 = false;
                          b3 = false;
                          b4 = false;
                          //
                          select =  "Select Time (Click here)";
                          select1 = "Select Time (Click here)";
                          select2 = "Select Time (Click here)";
                          select3 = "Select Time (Click here)";
                          select4 = "Select Time (Click here)";
                        }
                        else  if(_selectedFruits[2]== true){
                          selectshow1=true;
                          selectshow2=true;
                          selectshow3=false;
                          selectshow4=false;
                          //
                          b = false;
                          b1 = false;
                          b2 = false;
                          b3 = false;
                          b4 = false;
                          //
                          select =  "Select Time (Click here)";
                          select1 = "Select Time (Click here)";
                          select2 = "Select Time (Click here)";
                          select3 = "Select Time (Click here)";
                          select4 = "Select Time (Click here)";
                        }
                        else  if(_selectedFruits[3]== true){
                          selectshow1=true;
                          selectshow2=true;
                          selectshow3=true;
                          selectshow4=false;
                          //
                          b = false;
                          b1 = false;
                          b2 = false;
                          b3 = false;
                          b4 = false;
                          //
                          select =  "Select Time (Click here)";
                          select1 = "Select Time (Click here)";
                          select2 = "Select Time (Click here)";
                          select3 = "Select Time (Click here)";
                          select4 = "Select Time (Click here)";

                        }
                        else  if(_selectedFruits[4]== true){
                          selectshow1=true;
                          selectshow2=true;
                          selectshow3=true;
                          selectshow4=true;
                          //
                          b = false;
                          b1 = false;
                          b2 = false;
                          b3 = false;
                          b4 = false;
                          //
                          select =  "Select Time (Click here)";
                          select1 = "Select Time (Click here)";
                          select2 = "Select Time (Click here)";
                          select3 = "Select Time (Click here)";
                          select4 = "Select Time (Click here)";
                        }

                      });
                    },

                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.green,
                    selectedColor: Colors.white,
                    fillColor: Colors.lightGreen,
                    color: Colors.black,
                    constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 110

                    ),
                    isSelected: _selectedFruits,
                    children: fruits,
                  ),
                ),
                //  Text("$_selectedFruits"),

                ///////////
                const SizedBox(height: 20,),
                const Text("Set Time*"),
                const SizedBox(height: 30,),

//----------
                InkWell(
                    onTap: (){

                      if(selectshow == true){
                        selectTime();
                        select ="";


                        hide = true;
                      }
                    },

                    child:  Text("$select - " + _timeOfDay.hour.toString() + ":" + _timeOfDay.minute.toString()
                      , style: TextStyle(fontSize: 15),)),
                SizedBox(height: 10,),
                //22222222222222
                Visibility(
                  visible: selectshow1,
                  child: InkWell(
                      onTap: (){

                        if(selecttime1 == true){
                          select1 = "";
                          selectTime1();
                          b1 = true;

                          hide = true;
                        }
                      },

                      child:  Column(
                        children: [
                          Text("$select1 - " + _timeOfDay1.hour.toString() + ":" + _timeOfDay1.minute.toString()
                            , style: TextStyle(fontSize: 15),),
                          Visibility(
                              visible: b1,
                              child: ElevatedButton(
                                onPressed: (){

                                  FlutterAlarmClock.createAlarm(
                                    _timeOfDay1.hour, _timeOfDay1.minute,
                                    title: _titleController.text,);

                                },
                                child: Text('Set'),
                              )),
                        ],
                      )),
                ),
                SizedBox(height: 10,),
                //33333333333333
                Visibility(
                  visible: selectshow2,
                  child: InkWell(
                      onTap: (){

                        setState(() {
                          if(selecttime2== true){
                            select2 = "";
                            selectTime2();
                            b2 = true;

                            hide = true;
                          }
                        });
                      },

                      child:  Column(
                        children: [
                          Center(
                            child: Text("$select2 - "+ _timeOfDay2.hour.toString() + ":" + _timeOfDay2.minute.toString()
                              , style: TextStyle(fontSize: 15),),
                          ),
                          Visibility(
                              visible: b2,
                              child: ElevatedButton(onPressed: () async{
                                FlutterAlarmClock.createAlarm(
                                  _timeOfDay2.hour, _timeOfDay2.minute,
                                  title: _titleController.text,);
                              }, child: Text('Set'))),
                        ],
                      )),
                ),
                SizedBox(height: 10,),
                //44444444444444
                Visibility(
                  visible: selectshow3,
                  child: InkWell(
                      onTap: (){

                        if(selecttime3== true){
                          select3 = "";
                          selectTime3();
                          b3 = true;

                          hide = true;
                        }
                      },

                      child:  Column(
                        children: [
                          Text("$select3 - "+ _timeOfDay3.hour.toString() + ":" + _timeOfDay3.minute.toString()
                            , style: TextStyle(fontSize: 15),),
                          Visibility(
                              visible: b3,
                              child: ElevatedButton(
                                onPressed: (){

                                  FlutterAlarmClock.createAlarm(
                                    _timeOfDay3.hour, _timeOfDay3.minute,
                                    title: _titleController.text,);

                                },
                                child: Text('Set'),
                              )),
                        ],
                      )),
                ),
                ///55555555555555
                SizedBox(height: 10,),
                Visibility(
                  visible: selectshow4,
                  child: InkWell(
                      onTap: (){


                        if(selecttime4== true){
                          select4 = "";
                          selectTime4();
                          b4 = true;

                          hide = true;
                        }
                      },

                      child:  Column(
                        children: [
                          Text("$select4 - "+ _timeOfDay4.hour.toString() + ":" + _timeOfDay4.minute.toString()
                            , style: TextStyle(fontSize: 15),),
                          Visibility(
                              visible: b4,
                              child: ElevatedButton(
                                onPressed: (){

                                  FlutterAlarmClock.createAlarm(
                                    _timeOfDay4.hour, _timeOfDay4.minute,
                                    title: _titleController.text,);

                                },
                                child: Text('Set'),
                              )),
                        ],
                      )),
                ),



                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(
                    //  right: 40
                  ),
                  child: Visibility(
                    visible: set_label,
                    child: Container(
                      alignment: Alignment.topRight,
                      height: 50,
                      width: 120,

                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(),
                          borderRadius:  BorderRadius.circular(20)
                      ),

                      child: Center(
                        child: TextButton(
                          onPressed: (){

                            FlutterAlarmClock.showAlarms();

                          },
                          child: Text('Label Set',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ),

/*
                Visibility(
                    visible: hide,
                    child: InkWell(
                        onTap: (){
                          selectTime();
                        },
                        child: Text( _timeOfDay.hour.toString() + ":" + _timeOfDay.minute.toString()))),*/

                const SizedBox(height: 20,),

                Container(
                  child :
                  Column(children: <Widget>[

                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.green, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue = data!;
                        });
                      },
                      items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    Text('Selected Item = ' + '$dropdownValue',
                        style: const TextStyle
                          (fontSize: 14,
                            color: Colors.black)),
                  ]),
                ),
                const SizedBox(height: 20,),
                const Text("Alert Type", style: TextStyle(color: Colors.green),),

                const SizedBox(height: 5),
                ToggleButtons(
                  direction: vertical ? Axis.vertical : Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _alerttype.length; i++) {
                        _alerttype[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.green,
                  selectedColor: Colors.white,
                  fillColor: Colors.lightGreen,
                  color: Colors.black,
                  constraints:  const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 100.0,
                  ),
                  isSelected: _alerttype,
                  children: alerttype,
                ),

                const SizedBox(height: 30,),


                Container(
                  height: 50,
                  width: 80,

                  decoration: BoxDecoration(
                      color: Colors.green,
                   //   border: Border.all(),
                      borderRadius:  BorderRadius.circular(20)
                  ),

                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {





                          FlutterAlarmClock.createAlarm(
                            _timeOfDay.hour, _timeOfDay.minute,
                            title: _titleController.text,);







                          //   if(_selectedFruits[1]==true){



                          //   }


                          // Save new journal
                          //  if (id == null) {
                          await _addItem();
                          //  }

                          //    if (id != null) {
                          //  await _updateItem(id);
                          //   }

                          // Clear the text fields
                          _titleController.text = '';
                          _descriptionController.text = '';




                          // Close the bottom sheet
                          Navigator.of(context).pop();





                        },
                        child: const Text("Save",style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
  Future<void> selectTime() async{
    TimeOfDay ? _picker= await showTimePicker(context: context,
        initialTime: _timeOfDay);
    if(_picker != null){
      setState(() {
        _timeOfDay= _picker;
      });
    }
  }
  Future<void> selectTime1() async{
    TimeOfDay ? _picker= await showTimePicker(context: context,
        initialTime: _timeOfDay1);
    if(_picker != null){
      setState(() {
        _timeOfDay1= _picker;
      });
    }
  }
  Future<void> selectTime2() async{
    TimeOfDay ? _picker= await showTimePicker(context: context,
        initialTime: _timeOfDay2);
    if(_picker != null){
      setState(() {
        _timeOfDay2= _picker;
      });
    }
  }
  Future<void> selectTime3() async{
    TimeOfDay ? _picker= await showTimePicker(context: context,
        initialTime: _timeOfDay3);
    if(_picker != null){
      setState(() {
        _timeOfDay3= _picker;
      });
    }
  }
  Future<void> selectTime4() async{
    TimeOfDay ? _picker= await showTimePicker(context: context,
        initialTime: _timeOfDay4);
    if(_picker != null){
      setState(() {
        _timeOfDay4= _picker;
      });
    }
  }

// Retrieve the alarm label


}
