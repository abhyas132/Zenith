import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  postDataStatic() async {
    var response = await http
        .post(Uri.parse('http://localhost:3000/api/v1/create/task'), body: {
      "title": _title1,
      "description": _description1,
      "duration": _selectedItem,
    });
    print(response.body);
  }

  postDataDynamic() async {
    var response = await http
        .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
      "title": _title2,
      "description": _description2,
      "startTime": formatTimeOfDay(_startTime),
      "endTime": formatTimeOfDay(_endTime),
    });
    print(response.body);
  }

  List<String> _durationhrs = ["1", "1.5", "2.5", "3", "3.5", "4", "4.5"];
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  final _formKey = GlobalKey<FormState>();
  String _title1 = '';
  String _title2 = '';
  String _duration = '';
  String _description1 = '';
  String _description2 = '';
  double? _selectedItem;
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
      body: Padding(
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
    );
  }

  Widget _buildStaticForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
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
          // TextFormField(
          //   decoration: InputDecoration(
          //     labelText: 'Duration',
          //     border: OutlineInputBorder(),
          //   ),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'Please enter a duration';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     _duration = value!;
          //   },
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Duration"),
              DropdownButton<String>(
                value: _selectedItem.toString(),
                items: _durationhrs.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? selectedItem) {
                  setState(() {
                    _selectedItem = double.parse(selectedItem!);
                    print(_selectedItem);
                  });
                },
              ),
            ],
          ),
          // TextButton(
          //   onPressed: () => _selectTime(context),
          //   child: Text(
          //     _selectedTime.format(context),
          //     style: TextStyle(fontSize: 20.0),
          //   ),
          // ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
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
                  _formKey.currentState!.save();
                  print(_title1);
                  postDataStatic();
                  // Save the data to your database or perform any other necessary action.
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDynamicForm() {
    return Container(
        // Replace this with your dynamic form code.
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
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
          // TextFormField(
          //   decoration: InputDecoration(
          //     labelText: 'Start Time',
          //     border: OutlineInputBorder(),
          //   ),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'Please enter a duration';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     _duration = value!;
          //   },
          // ),
          Row(children: [
            Text("Start Time"),
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
          // TextFormField(
          //   decoration: InputDecoration(
          //     labelText: 'End Time',
          //     border: OutlineInputBorder(),
          //   ),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'Please enter a duration';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     _duration = value!;
          //   },
          // ),
          Row(
            children: [
              Text("End Time"),
              TextButton(
                onPressed: () => _selectTime(context),
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
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            onSaved: (value) {
              _description2 = value!;
            },
          ),
          SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(formatTimeOfDay(_startTime));
                  postDataDynamic();
                  // Save the data to your database or perform any other necessary action.
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
