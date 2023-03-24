import 'dart:developer';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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

  postDataDynamic() async {
    try {
      var response =
          await http.post(Uri.parse('${url}api/v1/create/task'), body: {
        "title": _title1,
        "description": _description1,
        "taskTag": options[tag],
        "duration": (_selectedItem),
        "taskType": "dynamic"
      });
      print(response.body);
    } catch (e) {
      print(e.toString());
      ShowSnakBar(context: context, content: e.toString());
    }
  }

  postDataStatic() async {
    try {
      var response =
          await http.post(Uri.parse('${url}api/v1/create/task'), body: {
        "title": _title2,
        "description": _description2,
        "startTime": (formatTimeOfDay(_startTime)),
        "endTime": (formatTimeOfDay(_endTime)),
        "duration": "0",
        "taskType": "static"
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Container(
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
                      groupValue: _isStatic,
                      onChanged: (bool? val) {
                        setState(() {
                          _isStatic = val!;
                        });
                      },
                    ),
                    Text('Static'),
                    SizedBox(width: 32),
                    Radio(
                      value: false,
                      groupValue: _isStatic,
                      onChanged: (bool? value) {
                        setState(() {
                          _isStatic = value!;
                        });
                      },
                    ),
                    Text('Dynamic'),
                  ],
                ),
                SizedBox(height: 16),
                _isStatic ? _buildStaticForm() : _buildDynamicForm(),
              ],
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Duration"),
                  DropdownButton<String>(
                    value: _selectedItem,
                    items: _durationhrs.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      try {
                        _formKey.currentState!.save();
                        print(_title1);
                        postDataDynamic();
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
                Text("Start Time"),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    _startTime.format(context),
                    style: TextStyle(fontSize: 20.0),
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
                  Text("End Time"),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () => _selectTime2(context),
                    child: Text(
                      _endTime.format(context),
                      style: TextStyle(fontSize: 20.0),
                    ),
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
                child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    try {
                      if (_formKey1.currentState!.validate()) {
                        _formKey1.currentState!.save();
                        print(formatTimeOfDay(_startTime));
                        postDataStatic();
                        // Save the data to your database or perform any other necessary action.
                      }
                    } catch (e) {
                      ShowSnakBar(context: context, content: e.toString());
                    }
                  },
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}
