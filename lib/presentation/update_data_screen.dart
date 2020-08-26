import 'package:flutter/material.dart';

class PageCParameters{
  final String title;
  const PageCParameters(this.title);
}

class UpdateDataScreen extends StatefulWidget {
  final String title;
  UpdateDataScreen({this.title});

  @override
  _PageCScreenState createState() => _PageCScreenState();
}

class _PageCScreenState extends State<UpdateDataScreen> {
  @override
  Widget build(BuildContext context) {
    //final PageCParameters args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("PageC")),
      body: Center(child: Text('Hello')
      ),
    );
  }
}