import 'package:flutter/material.dart';
import 'package:take_home_exam_240_420/config/route.dart';
import 'package:take_home_exam_240_420/presentation/home_screen.dart';
import 'package:take_home_exam_240_420/presentation/update_data_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Navigator",
        routes: {
          '/': (context) => HomeScreen(),
          '/edit_data': (context) => UpdateDataScreen(),
        //onGenerateRoute: _registerRouteParameters,
        }
        );
  }
}
