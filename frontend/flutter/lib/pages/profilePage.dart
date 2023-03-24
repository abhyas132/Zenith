import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [
                const Color(0xFF26CBE6),
                const Color(0xFF26CBC0),
              ], begin: Alignment.topCenter, end: Alignment.center)),
            ),
            new Scaffold(
              backgroundColor: Colors.transparent,
              body: new Container(
                child: new Stack(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.center,
                      child: new Padding(
                        padding: new EdgeInsets.only(top: _height / 15),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                  "https://blog.boot.dev/img/800/anonymous-person.png.webp"),
                              radius: _height / 10,
                            ),
                            new SizedBox(
                              height: _height / 30,
                            ),
                            new Text(
                              'Ayush Mishra',
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: _height / 2.2),
                      child: new Container(
                        color: Colors.white,
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                          top: _height / 2.6,
                          left: _width / 20,
                          right: _width / 20),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 2.0,
                                      offset: new Offset(0.0, 2.0))
                                ]),
                            child: new Padding(
                              padding: new EdgeInsets.all(_width / 20),
                              child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    headerChild('Streak', 12),
                                    headerChild('Followers', 1205),
                                    headerChild('ZenCoin', 120),
                                  ]),
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: _height / 20),
                            child: new Column(
                              children: <Widget>[
                                infoChild(
                                    _width, Icons.email, 'ayush108@gmail.com'),
                                infoChild(_width, Icons.call, '+12-1234567890'),
                                infoChild(
                                    _width, Icons.group_add, 'Add to group'),
                                infoChild(_width, Icons.chat_bubble,
                                    'Show all comments'),
                                new Padding(
                                  padding:
                                      new EdgeInsets.only(top: _height / 30),
                                  child: new Container(
                                    width: _width / 3,
                                    height: _height / 20,
                                    decoration: new BoxDecoration(
                                        color: const Color(0xFF26CBE6),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(_height / 40)),
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.black87,
                                              blurRadius: 2.0,
                                              offset: new Offset(0.0, 1.0))
                                        ]),
                                    child: new Center(
                                      child: new Text('FOLLOW ME',
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerChild(String header, int value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: const Color(0xFF26CBE6),
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}
