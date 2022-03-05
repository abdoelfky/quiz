// ignore: file_names
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../models/Course.dart';

class InstructorServices {
  static void getCourses(String email, ValueChanged<List<Course>> handler) async {
    FormData form=FormData.fromMap({
      'option': '2', 'email': email
    });
print('aaaaaaaaaaaaaa');
    var response = await Dio().post('http://test.vps51796.mylogin.co/exam_web/exam.php', data: form);
   print('response :  $response');
    final parsedJson = jsonDecode(response.toString());
    print(response.toString());
    print(";;;;;;;;;;;;;;;");
    print(parsedJson.toString());
    print("---------------------");
    var courseObjJson = jsonDecode(response.toString())["courses"] as List;
    List<Course> courseList = courseObjJson.map((courseJson) => Course.fromJson(courseJson)).toList();
    /*
    print(courseList.length);
    for(int i = 0;i < courseList.length ; i++)
      courseList[i].display();

     */
    //courseList.map((course)=> course.display());
    handler(courseList);
  }
}