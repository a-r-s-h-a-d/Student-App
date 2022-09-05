import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_details/db/function/db_function.dart';
import 'package:student_details/db/model/data_model.dart';
import 'package:student_details/screens/edit_student.dart';
import 'package:student_details/screens/search_students.dart';
import 'package:student_details/screens/student_details.dart';

import 'add_students.dart';

class ViewStudents extends StatelessWidget {
  const ViewStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Students'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const searchstudent()),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: StudentListNotifier,
          builder: (BuildContext context, List<StudentModel> StudentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = StudentList[index];
                  return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return StudentDetails(
                              student: data,
                            );
                          }),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                      ),
                      title: Text(data.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EditStudent(
                                        student: data,
                                      )));
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDeletedAlertBox(context, data);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ));
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: StudentList.length);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddStudents();
                },
              ),
            );
          },
          tooltip: 'Add Student',
          child: const Icon(Icons.add),
        ));
  }
}

void showDeletedAlertBox(BuildContext context, StudentModel data) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Text("Do You Want to delete this?"),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
                TextButton(
                    onPressed: () {
                      deleteStudent(data.key);
                      Navigator.pop(ctx);
                    },
                    child: Text('Yes'))
              ],
            )
          ],
        );
      });
}
