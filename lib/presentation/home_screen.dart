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
  List<Map> sortedData = [];
  void addData(newitem) {
    int idx = 0;
    if (data.length == 0) {
      idx = 0;
    } else {
      idx = data.last['id'] + 1;
    }
    Map tmp = {'name': newitem['name'], 'value': 27, 'id': idx};
    data.add(tmp);
  }

  void _sortList() {
    sortedData = List.from(data);
    sortedData.sort((a, b) => a['value'].compareTo(b['value']));
  }

  void _updateValue() {
    setState(() {
      addData(data1);
      addData(data2);
      addData(data3);
      _sortList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My List")),
      body: ListView.separated(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text('${data[index]['id']} ${data[index]['name']}'),
              trailing: Text('${data[index]['value']}'),
              //onTap: () => {Navigator.of(context).pushNamed(AppRouter.edit_data)},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      todo: data,
                      currentIDX: index,
                    ),
                  ),
                );
              });
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
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
  final int currentIDX;
  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo, this.currentIDX})
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
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDataScreen(
                              todo: todo,
                              currentIDX: currentIDX,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        '${todo[currentIDX]['id']} ${todo[currentIDX]['name']}',
                        style: TextStyle(fontSize: 40),
                      ),
                      trailing: Text(
                        '${todo[currentIDX]['value']}',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      )),
                ],
              ),
            ),
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
                child: FittedBox(
                    fit: BoxFit.contain, child: Text("Next Person > ")),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.amber[50],
                height: 100,
                child: Text('${currentIDX} ${todo[currentIDX]['name']}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditDataScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final List<Map> todo;
  final int currentIDX;
  // In the constructor, require a Todo.
  EditDataScreen({Key key, @required this.todo, this.currentIDX})
      : super(key: key);

  @override
  double btnWidth = 100;
  double btnHeigth = 100;
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text("My List")),
      body: SafeArea(
          child: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text('Name ${todo[currentIDX]['name']}'),
            ),
            Text('${todo[currentIDX]['id']} ${todo[currentIDX]['value']}'),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: btnWidth,
                  height: btnHeigth,
                  child: Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: null,
                      child: Text('1'),
                    ),
                  ),
                ),
                SizedBox(
                    width: btnWidth,
                    height: btnHeigth,
                    child: RaisedButton(
                      color: Colors.black,
                      onPressed: null,
                      child: Text('2'),
                    )),
                SizedBox(
                  width: btnWidth,
                  height: btnHeigth,
                  child: RaisedButton(
                    onPressed: null,
                    child: Text('3'),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
