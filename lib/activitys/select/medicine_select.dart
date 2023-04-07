import 'dart:math';


import 'package:diabetes_self_care_new/activitys/figment_ac.dart';
import 'package:diabetes_self_care_new/activitys/pages/medicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

import '../pages/sql_helper.dart';



const List<Widget> fruits = <Widget>[
  Text('Once a Day'),
  Text('2 Times a Day'),
  Text('3 Times a Day')
];
const List<Widget> alerttype = <Widget>[
  Text('Notification'),
  Text('Alarm'),

];

class Medi_select extends StatefulWidget {

  @override
  State<Medi_select> createState() => _Medi_selectState();
}

class _Medi_selectState extends State<Medi_select> {
  //





  //

  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }































  //final selectTime = "Select Time (Click here)";

  static const String _title = 'ToggleButtons Sample';
  final List<bool> _selectedFruits = <bool>[true, false, false];
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
  TimeOfDay _timeOfDays = TimeOfDay.now();
  var time = DateTime.now();

 //
  bool selectshow = true;
  bool hide = false;

String select = "Select Time (Click here)";



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




// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _timeOfDay.toString()

    );
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
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
        appBar: AppBar(title: const Text("Add Medicine"),
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
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                   labelText: "Drug Name",
                    hintText: "Drug Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )

                    )
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
                Scrollbar(
                  child: ToggleButtons(

                    direction: vertical ? Axis.vertical : Axis.horizontal,

                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedFruits.length; i++) {
                          _selectedFruits[i] = i == index;
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
                  
                ///////////
                const SizedBox(height: 20,),
                const Text("Set Time*"),
                const SizedBox(height: 30,),


                InkWell(
                  onTap: (){

                    if(selectshow == true){
                      select = "";
                      selectTime();

                      hide = true;
                    }
                  },

                    child:  Text("$select"
                      , style: TextStyle(fontSize: 15),)),


                Visibility(
                    visible: hide,
                    child: InkWell(
                        onTap: (){
                          selectTime();
                        },
                        child: Text( _timeOfDay.hour.toString() + ":" + _timeOfDay.minute.toString()))),

                const SizedBox(height: 20,),

                Container(
                  child :
                  Column(children: <Widget>[

                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
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
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),

                  child: TextButton(
                    onPressed: () async {

                     FlutterAlarmClock.createAlarm(_timeOfDay.hour,_timeOfDay.minute);
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
}
