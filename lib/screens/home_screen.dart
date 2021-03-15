import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todos = [];
  TextEditingController input = new TextEditingController();

  void handleAddTolist() {
    setState(() {
      todos.add(input.text);
      input.text = "";
    });
  }

  void handleRemoveTodoFromList(String item) {
    setState(() {
      todos.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo list",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      controller: input,
                      onFieldSubmitted: (s) => handleAddTolist(),
                      decoration: InputDecoration(
                        hintText: "รายการสิ่งที่ต้องทำ",
                        border: OutlineInputBorder(),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          child: IconButton(
                            onPressed: handleAddTolist,
                            icon: Icon(
                              Icons.list,
                              color: Colors.blue,
                            ),
                          ), // myIcon is a 48px-wide widget.
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "รายการ:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: todos
                    .map(
                      (item) => Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$item"),
                                IconButton(
                                  onPressed: () {
                                    handleRemoveTodoFromList(item);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
