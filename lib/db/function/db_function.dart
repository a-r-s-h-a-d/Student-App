import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_details/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> StudentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
//open box
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  //adding values to database
  await studentDB.add(value);
  //adding values to StudentListNotifier
  StudentListNotifier.value.add(value);

  StudentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  StudentListNotifier.value.clear();
  StudentListNotifier.value.addAll(studentDB.values);
  StudentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getAllStudents();
}
Future<void> updateStudent(int id,StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.put(id,value);
  getAllStudents();
}

// Future<void> editstudent(int key, StudentModel value) async {
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   studentDB.putAt(key, value);
//   getAllStudents();
// }
