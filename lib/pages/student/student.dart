import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_implementation/models/student.dart';
import 'package:hive_implementation/pages/student/add_student.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box('students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: studentBox.length,
          itemBuilder: ((context, index) {
            final student = studentBox.getAt(index) as Student;

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.id.toString()),
                    Text(student.name.toString()),
                    Text(student.age.toString()),
                    Text(student.subject.toString()),
                  ],
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddStudent(),
              ));
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
