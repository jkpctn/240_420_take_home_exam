import 'package:flutter/material.dart';
import 'package:take_home_exam_240_420/config/route.dart';

List<Map> data = [];
List<Map> sortedData = [];

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

  void addData(newitem) {
    int idx = 0;
    if (data.length == 0) {
      idx = 0;
    } else {
      idx = data.last['id'] + 1;
    }
    Map tmp = {'name': newitem['name'], 'value': newitem['value'], 'id': idx};
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
  String findNextPerson() {
    return '5';
  }

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
                height: 100,
                child: Text(''),
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
                //color: Colors.amber[50],
                height: 100,
                child: Text(
                  //'$currentIDX ${todo[currentIDX]['name']}',
                  '$findNextPerson',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditDataScreen extends StatefulWidget {
  final List<Map> todo;
  final int currentIDX;
  // In the constructor, require a Todo.
  EditDataScreen({Key key, @required this.todo, this.currentIDX})
      : super(key: key);
  @override
  final double btnWidth = 100;
  final double btnHeigth = 100;

  @override
  _EditDataScreenState createState() => _EditDataScreenState(
      this.currentIDX, this.todo[this.currentIDX]['value'].toString());
}

class _EditDataScreenState extends State<EditDataScreen> {
  double btnWidth = 90;
  double btnHeigth = 90;
  int currentIDX;
  String _val;
  _EditDataScreenState(this.currentIDX, this._val);
  List<List<String>> btnText = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['CLR', '0', 'OK']
  ];
  void saveData() {
    debugPrint('Save');
  }

  void onPress(String id) {
    setState(() {
      debugPrint('pressed $id');
      switch (id) {
        case "CLR":
          {
            _val = '';
          }
          break;
        case "OK":
          {
            saveData();
          }
          break;
        default:
          {
            _val = _val + id;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Use the Todo to create the UI.
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("My List")),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Name ',
                    style: TextStyle(fontSize: 25),
                  ),
                  Container(
                    width: 200.0,
                    height: 40,
                    child: TextField(
                        decoration: InputDecoration(
                            labelText:
                                '${this.widget.todo[this.widget.currentIDX]['name']}'),
                        style: TextStyle(fontSize: 25)),
                  )
                ]),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        color: Colors.blue[100],
                        child: Center(
                            child: Text(
                          '$_val',
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        ))))
              ],
            ),
            for (var row in btnText)
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    for (var item in row)
                      Container(
                        width: btnWidth,
                        height: btnHeigth,
                        child: RaisedButton(
                          color: Colors.blue[50],
                          onPressed: () => onPress(item),
                          child: Text(
                            '$item',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      )
                  ]),
          ],
        ),
      )),
    );
  }
}
