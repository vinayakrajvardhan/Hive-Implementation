import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_implementation/pages/teacher/add_teacher.dart';

import '../../models/teacher.dart';
import 'edit_teacher.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  late Box<Teacher> teacherBox;

  @override
  void initState() {
    teacherBox = Hive.box<Teacher>('teachers');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ValueListenableBuilder(
              valueListenable: teacherBox.listenable(),
              builder: (context, box, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: teacherBox.length,
                    itemBuilder: (context, index) {
                      final teacher = teacherBox.getAt(index) as Teacher;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditTeacherScreen(index: index),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                teacher.id.toString(),
                              ),
                              Text(
                                teacher.name.toString(),
                              ),
                              Text(
                                teacher.age.toString(),
                              ),
                              Text(
                                teacher.subject.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddTeacher(),
              ));
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
