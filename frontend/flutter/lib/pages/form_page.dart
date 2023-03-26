import 'dart:convert';
import 'dart:developer';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenith/globalvariables.dart';
import 'package:zenith/utils/snackbar.dart';

const url = GlobalVariables.baseUrl;

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  String taskType = "static";
  int tag = 0;
  List<String> tags = [];
  List<String> options = ['flexible', 'morning', 'afternoon', 'evening'];
  // GlobalVariables GL =  GlobalVariables();
  String formatTimeOfDay(TimeOfDay selectedTime) {
    var replacingTime = selectedTime.replacing(
        hour: selectedTime.hour, minute: selectedTime.minute);

    String formattedhour = replacingTime.hour < 10
        ? "0" + replacingTime.hour.toString()
        : replacingTime.hour.toString();
    String formattedminute = replacingTime.minute > 10
        ? replacingTime.minute.toString()
        : "0" + replacingTime.minute.toString();
    String formattedTime = formattedhour + formattedminute;
    print(formattedTime);
    return (formattedTime);
    //return formattedTime.replaceFirst(RegExp(':'), '');
  }

  Future<void> postDataDynamic() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      var response = await http.post(
        Uri.parse('${url}api/v1/create/task'),
        body: jsonEncode({
          "title": _title1,
          "description": _description1,
          "taskTag": options[tag],
          "duration": (_selectedItem),
          "taskType": "dynamic"
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer " + token!
        },
      );
      print(response.body);
    } catch (e) {
      print(e.toString());
      ShowSnakBar(context: context, content: e.toString());
    }
  }

  Future<void> postDataStatic() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      var response = await http.post(
        Uri.parse('${url}api/v1/create/task'),
        body: jsonEncode({
          "title": _title2,
          "description": _description2,
          "startTime": (formatTimeOfDay(_startTime)),
          "endTime": (formatTimeOfDay(_endTime)),
          "duration": "0",
          "taskType": "static"
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer " + token!
        },
      );
      print(response.body);
    } catch (e) {
      ShowSnakBar(context: context, content: e.toString());
    }
  }

  final List<String> _durationhrs = [
    '1',
    '1.5',
    '2',
    '2.5',
    '3',
    '3.5',
    '4',
    '4.5'
  ];
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  String _title1 = '';
  String _title2 = '';
  String _description1 = '';
  String _description2 = '';
  String _selectedItem = '1';
  // DateTime _dateTime;
  bool _isStatic = true;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          title: Text('Add New Item'),
        ),
        body: Container(
          height: 1456789876567,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background2.jpg"),
              opacity: 0.1,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: true,
                      activeColor: GlobalVariables.backgroundColor,
                      groupValue: _isStatic,
                      onChanged: (bool? val) {
                        setState(() {
                          _isStatic = val!;
                        });
                      },
                    ),
                    Text('Static',
                        style: TextStyle(
                            color: GlobalVariables.backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 32),
                    Radio(
                      activeColor: GlobalVariables.backgroundColor,
                      value: false,
                      groupValue: _isStatic,
                      onChanged: (bool? value) {
                        setState(() {
                          _isStatic = value!;
                        });
                      },
                    ),
                    Text('Dynamic',
                        style: TextStyle(
                            color: GlobalVariables.backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 16),
                _isStatic ? _buildStaticForm() : _buildDynamicForm(),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicForm() {
    return Column(
      children: [
        ChipsChoice.single(
          value: tag,
          onChanged: (val) => setState(() => tag = val),
          choiceItems: C2Choice.listFrom(
              source: options, value: (i, v) => i, label: (i, v) => v),
          choiceActiveStyle: C2ChoiceStyle(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          choiceStyle: C2ChoiceStyle(color: Colors.black),
          wrapped: true,
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title1 = value!;
                  print(_title1);
                },
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Duration",
                          style: TextStyle(
                              color: GlobalVariables.backgroundColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: _selectedItem,
                        items: _durationhrs.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedItem = (selectedItem!);
                            print(_selectedItem);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Attention Time",
                          style: TextStyle(
                              color: GlobalVariables.backgroundColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: _selectedItem,
                        items: _durationhrs.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description1 = value!;
                  print(_description1);
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        GlobalVariables.backgroundColor),
                  ),
                  child: Text('Add Task'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        _formKey.currentState!.save();
                        print(_title1);
                        context.loaderOverlay.show();
                        await postDataDynamic();
                        context.loaderOverlay.hide();
                        ShowSnakBar(
                            context: context,
                            content: "Task added successfully");
                      } catch (e) {
                        ShowSnakBar(context: context, content: e.toString());
                      }
                      // Save the data to your database or perform any other necessary action.
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStaticForm() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
            // Replace this with your dynamic form code.
            child: Form(
          key: _formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title2 = value!;
                },
              ),
              SizedBox(height: 16),
              Row(children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Start Time",
                  style: TextStyle(
                      color: GlobalVariables.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  //style: TextStyle(color:),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    style: TextStyle(
                        color: GlobalVariables.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    _startTime.format(context),
                  ),
                ),
              ]),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "End Time",
                    style: TextStyle(
                        color: GlobalVariables.backgroundColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () => _selectTime2(context),
                    child: Text(_endTime.format(context),
                        style: TextStyle(
                            color: GlobalVariables.secondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  //log(value!);
                  _description2 = value!;
                },
              ),
              SizedBox(height: 32),
              Center(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(45)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          GlobalVariables.backgroundColor),
                    ),
                    child: Text('Add Task'),
                    onPressed: () async {
                      try {
                        if (_formKey1.currentState!.validate()) {
                          _formKey1.currentState!.save();
                          print(formatTimeOfDay(_startTime));
                          context.loaderOverlay.show();
                          await postDataStatic();

                          context.loaderOverlay.hide();
                          ShowSnakBar(
                              context: context,
                              content: "Task added successfully");
                          // Save the data to your database or perform any other necessary action.
                        }
                      } catch (e) {
                        ShowSnakBar(context: context, content: e.toString());
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}
