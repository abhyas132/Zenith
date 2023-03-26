import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenith/globalvariables.dart';
import 'package:zenith/models/user_modal.dart';

class SearchPage extends StatefulWidget {
  String txt;
  SearchPage({required this.txt, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final url = GlobalVariables.baseUrl;
  String? id;
  User? user;
  void search() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    final res = await http.post(
      Uri.parse("${url}api/v1/search/user"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + token!
      },
      body: jsonEncode(
        {
          "email": widget.txt,
        },
      ),
    );

    setState(() {
      isLog = false;
    });
    print(res.body);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body)['user'];
      id = data['_id'];
      user = User(
        name: data['name'],
        email: data['email'],
        // password: data['password'],
        zenCoins: data['zenCoins'],
        studyActivity: data['studyActivity'],
        sportActivity: data['sportActivity'],
        otherActivity: data['otherActivity'],
      );
    }
  }

  void addFriend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    final res = await http.post(
      Uri.parse("${url}api/v1/add/friend"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + token!
      },
      body: jsonEncode(
        {
          "id": id,
        },
      ),
    );

    print(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search();
  }

  bool isLog = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "searched result",
        ),
      ),
      body: isLog
          ? Center(
              child: CircularProgressIndicator(),
            )
          : user != null
              ? Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      //radius: 50,
                      backgroundImage: AssetImage('assets/man.png'),
                    ),
                    title: Text(
                      user!.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("add a friend"),
                    trailing: IconButton(
                      onPressed: () {
                        addFriend();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                )
              : Center(
                  child: Text("Not found"),
                ),
    );
  }
}
