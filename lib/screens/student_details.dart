import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_details/db/model/data_model.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails({Key? key, required this.student}) : super(key: key);
  StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: FileImage(File(student.image)),
                  radius: 60,
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text('Name : ${student.name}',
                          style: TextStyle(fontSize: 25))),
                  Center(
                      child: Text('Age : ${student.age}',
                          style: TextStyle(fontSize: 25))),
                  Center(
                      child: Text('Email :${student.email}',
                          style: TextStyle(fontSize: 25))),
                  Center(
                      child: Text('Contacts:${student.contacts}',
                          style: TextStyle(fontSize: 25)))
                ],
              )
              // TextFormField(
              //   decoration: InputDecoration(
              //       hintText: student.name,
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // const SizedBox(height: 30),
              // TextFormField(
              //   decoration: InputDecoration(
              //       hintText: student.age,
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // const SizedBox(height: 30),
              // TextFormField(
              //   decoration: InputDecoration(
              //       hintText: student.email,
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // const SizedBox(height: 30),
              // TextFormField(
              //   decoration: InputDecoration(
              //       hintText: student.contacts,
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // const SizedBox(height: 30),
              // Padding(
              //     padding: const EdgeInsets.only(left: 100.0, right: 90),
              //     child: ElevatedButton.icon(
              //       onPressed: () {},
              //       icon: Icon(Icons.add),
              //       label: Text('Add Student'),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
