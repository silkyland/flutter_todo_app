# Todo Application

Just another todo application using flutter.


### เริ่มโปรเจค

- สร้างไฟล์ screens/home_screen.dart และสร้าง class HomeScreen ด้วย StatefulWidget

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

- ที่ไฟล์ lib/main.dart ให้ตั้งค่า MyApp ส่วนของ MaterialApp เปลี่ยน ```home:``` ให้เป็น  HomeScreen แล้ว Import screen/home_screen.dart

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
