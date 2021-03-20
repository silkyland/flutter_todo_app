# Todo Application

ตัวอย่างการเขียน Application TODO ด้วย Flutter.

<img src="https://github.com/silkyland/flutter_todo_app/raw/master/howto/images/todo.png" width="480"/>

---

### สร้างโปรเจค

1. สร้างโปรเจคใหม่โดยไปที่เมนู View > Command Palette
2. เลือก Flutter: New Application Project
3. เลือกโฟล์เดอร์ที่เก็บ Project เช่น d:/flutterProj
4. ตั้งชื่อโปรเจคว่า todo

### Design Layout

<img src="https://github.com/silkyland/flutter_todo_app/raw/master/howto/images/flutter_layout.png" width="720"/>

### เริ่มโปรเจค

สร้างไฟล์ screens/home_screen.dart และสร้าง class HomeScreen ด้วย StatefulWidget

```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("home")),
    );
  }
}
```

---

## ไฟล์ lib/main.dart

ให้ตั้งค่า MyApp ส่วนของ MaterialApp เปลี่ยน `home:` ให้เป็น HomeScreen แล้ว Import screen/home_screen.dart

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
```

---

## ไฟล์ lib/screens/home_screen.dart

เพิ่ม `Scaffold()` และ `appbar:`

```dart
    Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo list",
        ),
      ),
    )
```

ใน `Scaffold()` เพิ่ม `body:`

```dart
    Scaffold(
        body: Container(
          child: Column(
            children: [],
          ),
        ),
    ),
```

เพิ่มส่วน `Form()`

```dart
    Scaffold(
        body: Container(
          child: Column(
            children: [
                Form(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "รายการสิ่งที่ต้องทำ",
                    border: OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.list,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ),
```

เพิ่มส่วน `Listview()` ใน `Column()` ถัดจาก `Form()`

```dart
    ListView(
        children: [],
    ),
```

ใน `ListView()` เพิ่มตัวอย่างโดยเพิ่ม `Card( Row[ Text, IconButton] )`

```dart
    ListView(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("รายการทดสอบ"),
                    IconButton(
                      onPressed: () {},
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
        ],
    ),
```

สร้างตัวแปร list ชื่อว่า `todos` ใน class `_HomeScreenState()` สำหรับเก็บข้อมูลรายการสิ่งที่ต้องทำ

```dart
    ...

    List<String> todos = []; // <--- เพิ่มบันทัดนี้

    ...
    @overide
    Widget build....
```

สร้างตัวแปร TextEditingController ชื่อว่า `input` ใน class `_HomeScreenState()` สำหรับเก็บข้อมูลที่ผู้ใช้กรอกเข้ามา

```dart
    ...
    TextEditingController input = new TextEditingController(); // <--- เพิ่มบันทัดนี้
    ...
    @overide
    Widget build....
```

สร้าง `void()` method ชื่อว่า `handleAddToList()` สำหรับเพิ่มข้อมูลที่ผู้ใช้กรอกเข้าไปยังตัวแปร `todos`

```dart
...
    void handleAddTolist() {
      setState(() {
        todos.add(input.text);
        input.text = "";
      });
    }

....
```

สร้าง `void()` method ชื่อว่า `handleRemoveTodoFromList(String item)` โดยรับค่า `String item` สำหรับลบข้อมูลที่ผู้ใช้เลือกออกจากตัวแปร `todos`

```dart
...

  void handleRemoveTodoFromList(String item) {
    setState(() {
      todos.remove(item);
    });
  }

....
```

ที่ `Form()` => `TextFormField()` เพิ่ม

```dart
    Form(
      child: TextFormField(
        controller: input,  // <--- เพิ่มบันทัดนี้
        decoration: InputDecoration(
          hintText: "รายการสิ่งที่ต้องทำ",
          border: OutlineInputBorder(),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: IconButton(
              onPressed: handleAddTolist, <--- เพิ่มบันทัดนี้
              icon: Icon(
                Icons.list,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    ),
```

ที่ `ListView()` เนื่องจากเรามีตัวแปรชื่อว่า `todos` แล้ว เราสามารถนำข้อมูล `todo` มาใช้ได้โดยการ `map()` ข้อมูลออกมาทีละรายการ ดังนี้
```dart
    // เดิม
    ListView(
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("รายการทดสอบ"),
                  IconButton(
                    onPressed: () {},
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
      ],
    ),

    // เปลี่ยนเป็น 
    ListView(
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
    
```

#### ตกแต่งเพื่อความสวยงาม
ที่ `Scaffold()` => `body: Container()` เพิ่ม `padding:` เพื่อให้ระยะห่างจากขอบจอขนาด 10.0 โดย
```dart
...

body: Container(
        padding: EdgeInsets.all(10), // <-- เพิ่มบันทัดนี้
        child: Column(

...
```

ที่ `Column[Form(), Text(), ListView()]` ให้เพิ่ม `SizedBox()` ความสูง 10 เพื่อไม่ให้ `Form()` และ `Text()` ติดกันจนเกินไปให้มีลักษณะ `Column[Form, SizedBox(), Text(), ListView()]` โดย
```dart
...

Form( ... ),
SizedBox(
  height: 10,
),
Text( ... ),

...
```

เนื่องจาก `ListView()` สามารถเลื่อน (scroll) ได้ดังนั้นหากเนื้อหามีขนาดยาวเกินหน้า ระบบจะไม่สามารถแสดงผลได้จึงจำเป็นต้องนำ `Expanded()` มาครอบ `ListView()` ไว้เพื่อให้ความยาวของ `ListView()` ยืดหยุ่นได้ โดย กดปุ่ม `ctrl + .` (Windows) หรือ `cmd + .` (Mac) ที่ด้านหน้าของ ListView ที่เราจะครอบ เลือก "Wrap with widget" แล้วแก้ `widget` เป็น `Expanded()`
```dart
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
    ),

```


ลอง Run โดยการกดปุ่ม `F5` บนแป้นพิมพ์

### Credit
Bundit Nuntates

----
### License
MIT
