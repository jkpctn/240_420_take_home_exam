import 'package:flutter/material.dart';
import 'package:take_home_exam_240_420/config/route.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListDisplay(title: 'My List'));
  }
}

class ListDisplay extends StatefulWidget {
  ListDisplay({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  _ListDisplayState createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  int ivalue = 0;
  Data x = Data(
    name: 'John',
    value: 80,
  );
  Map data1 = {'name': 'Pikachu', 'value': 27};
  Map data2 = {'name': 'Charlizard', 'value': 36};
  Map data3 = {'name': 'Lucario', 'value': 80};
  List<Map> data = [];

  List<String> names = ['A', 'B', 'C', 'D', 'E'];
  List<int> values = [1, 2, 3, 4, 5];
  void _updateValue() {
    setState(() {
      data.add(data1);
      data.add(data2);
      data.add(data3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My List")),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text('$index ${data[index]['name']}'),
                trailing: Text('${data[index]['value']}'),
                //onTap: () => {Navigator.of(context).pushNamed(AppRouter.edit_data)},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        todo: data,
                        current_idx: index,
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateValue,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Data {
  String name;
  int value;
  Data({
    this.name,
    this.value,
  });
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final List<Map> todo;
  final int current_idx;
  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo, this.current_idx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text("My List")),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: ListTile(
                    title: Text('$current_idx ${todo[current_idx]['name']}'),
                    trailing: Text(
                      '${todo[current_idx]['value']}',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ))),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber[50],
                height: 100,
                child: Text('FREE SPACE'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue[100],
                height: 100,
                child: FittedBox(fit: BoxFit.contain, child: Text("Next Person > ")),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.amber[50],
                height: 100,
                child: Text('${current_idx} ${todo[current_idx]['name']}'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
