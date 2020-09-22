import 'package:flutter/material.dart';
import 'package:take_home_exam_240_420/config/route.dart';

List<Map> data = [];
List<Map> sortedData = [];
void _sortList() {
  sortedData = List.from(data);
  sortedData.sort((a, b) => a['value'].compareTo(b['value']));
  debugPrint('Sorted');
}

int _findNextPersonIDX(int currentIDX) {
  debugPrint('unsorted $data');
  debugPrint('sorted $sortedData');
  debugPrint('idx in detail screen :$currentIDX');
  int currIdxInSorted = sortedData.indexOf(data[currentIDX]);
  if (currIdxInSorted == sortedData.length - 1) {
    debugPrint('last item');
    debugPrint('next idx $currIdxInSorted');
    return -1;
  } else {
    debugPrint('not last item');
    debugPrint('next idx ${currIdxInSorted + 1}');
    return data.indexOf(sortedData[currIdxInSorted + 1]);
  }
}

void makeRoutePage({BuildContext context, Widget pageRef}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageRef),
      (Route<dynamic> route) => false);
}

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
  Map data1 = {'name': 'Pikachu', 'value': 27};
  Map data2 = {'name': 'Charlizard', 'value': 36};
  Map data3 = {'name': 'Lucario', 'value': 80};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(135, 206, 250, 1),
      appBar: AppBar(title: Text("My List")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
              height: 65,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                      title: Text(
                        '${data[index]['id']}   ${data[index]['name']}',
                        style: TextStyle(fontSize: 25),
                      ),
                      trailing: Text(
                        '${data[index]['value']}',
                        style: TextStyle(fontSize: 30),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              todo: data,
                              currentIDX: index,
                              nextPersonIDX: _findNextPersonIDX(index),
                            ),
                          ),
                        );
                      })));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputForm(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  InputForm({Key key}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  void addData() {
    String name = nameController.text;
    String strValue = valueController.text;
    int value = int.parse(strValue);
    int idx = 0;
    if (data.length == 0) {
      idx = 0;
    } else {
      idx = data.last['id'] + 1;
    }
    Map tmp = {'name': name, 'value': value, 'id': idx};
    data.add(tmp);
    makeRoutePage(context: context, pageRef: ListDisplay());
    _sortList();
  }

  @override
  void dispose() {
    nameController.dispose();
    valueController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("New Person")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 100, 255, .5),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your name',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 100, 255, .5),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextFormField(
                          controller: valueController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your value',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        addData();
                      }
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(0, 100, 255, .5),
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))),
              ],
            ),
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final List<Map> todo;
  final int currentIDX;
  final int nextPersonIDX;
  bool isLastPerson = false;
  String displayNextPerson = 'Default';
  String displayNextPersonTrailing = 'Default';
  // In the constructor, require a Todo.
  DetailScreen(
      {Key key, @required this.todo, this.currentIDX, this.nextPersonIDX})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (nextPersonIDX == -1) {
      displayNextPerson = 'None';
      displayNextPersonTrailing = '';
      debugPrint('idx null');
    } else {
      displayNextPerson = '$nextPersonIDX ${data[nextPersonIDX]['name']}';
      displayNextPersonTrailing = '${data[nextPersonIDX]['value']}';
      debugPrint('apply text');
    }
    // Use the Todo to create the UI.
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue[100],
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
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), color: Colors.white),
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDataScreen(
                                    todo: data,
                                    currentIDX: currentIDX,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      )),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ListTile(
                          title: Text(
                            '${data[currentIDX]['id']}   ${data[currentIDX]['name']}',
                            style: TextStyle(fontSize: 30),
                          ),
                          trailing: Text(
                            '${data[currentIDX]['value']}',
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          ))),
                ],
              ),
            ),
            SizedBox(
              height: 180,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue[200],
                child:
                    FittedBox(fit: BoxFit.contain, child: Text("Next Person ")),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text(
                    '$displayNextPerson',
                    style: TextStyle(fontSize: 35),
                  ),
                  trailing: Text('$displayNextPersonTrailing',
                      style: TextStyle(fontSize: 30)),
                  onTap: () {
                    if (nextPersonIDX != -1)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            todo: data,
                            currentIDX: nextPersonIDX,
                            nextPersonIDX: _findNextPersonIDX(nextPersonIDX),
                          ),
                        ),
                      );
                  },
                )),
            SizedBox(
              height: 20,
            )
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
      this.currentIDX, data[this.currentIDX]['value'].toString());
}

class _EditDataScreenState extends State<EditDataScreen> {
  final nameTextFieldController = TextEditingController();
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
    debugPrint(nameTextFieldController.text);
    debugPrint(_val);
    String newName = '';
    if (_val == '') _val = '0';
    if (nameTextFieldController.text == "")
      newName = data[currentIDX]['name'];
    else
      newName = nameTextFieldController.text;
    data[currentIDX]['name'] = newName;
    data[currentIDX]['value'] = int.parse(_val);
    debugPrint('Save ');
    _sortList();
    makeRoutePage(context: context, pageRef: ListDisplay());
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
  void dispose() {
    nameTextFieldController.dispose();
    super.dispose();
  }

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
                        controller: nameTextFieldController,
                        decoration: InputDecoration(
                            hintText:
                                '${data[this.widget.currentIDX]['name']}'),
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
