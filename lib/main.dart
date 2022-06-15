import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_implementation/models/bank.dart';
import 'package:hive_implementation/models/office.dart';
import 'package:hive_implementation/models/student.dart';
import 'package:hive_implementation/models/teacher.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/bank/bank.dart';
import 'pages/home.dart';
import 'pages/office/office.dart';
import 'pages/student/student.dart';
import 'pages/teacher/teacher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');

  Hive.registerAdapter<Student>(StudentAdapter());
  Hive.registerAdapter<Teacher>(TeacherAdapter());
  Hive.registerAdapter<Bank>(BankAdapter());
  Hive.registerAdapter<Office>(OfficeAdapter());

  await Hive.openBox('home');
  await Hive.openBox<Student>('students');
  await Hive.openBox<Teacher>('teachers');
  await Hive.openBox<Bank>('banks');
  await Hive.openBox<Office>('officeDart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final String name = "all";
  

  final pages = [
    const HomeScreen(),
    const StudentScreen(),
    const TeacherScreen(),
    const BankScreen(),
    const OfficeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey.shade100,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Student'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Teacher'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Bank'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_post_office), label: 'Office')
        ],
      ),
    );
  }
}
