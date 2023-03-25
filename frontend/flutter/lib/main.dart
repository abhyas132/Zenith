import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenith/onBoarding/screens/onboding/onboding_screen.dart';
import 'package:zenith/pages/bodypage.dart';
import 'package:zenith/provider/user_provider.dart';
import 'package:zenith/services/auth_services.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool logged = false;
  AuthServices auth = AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isLoggedIn();
    auth.getUser(context);

    //print(Provider.of<UserProvider>(context).user.email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: logged ? body_page() : OnbodingScreen(),
      home: Provider.of<UserProvider>(context).user.email.isEmpty
          ? OnbodingScreen()
          : body_page(),
    );
  }
}
