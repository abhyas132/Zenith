import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  List<String> _durationhrs = ['1 hrs', '2 hrs', '3 hrs', '4 hrs'];
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _duration = '';
  String _description = '';
  String? _selectedItem;
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
              _title = value!;
              print(_title);
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
                value: _selectedItem,
                items: _durationhrs.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? selectedItem) {
                  setState(() {
                    _selectedItem = selectedItem!;
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
              _description = value!;
              print(_description);
            },
          ),
          SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(_title);
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
              _title = value!;
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
              _description = value!;
            },
          ),
          SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
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
