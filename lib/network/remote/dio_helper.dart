import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/models/Course.dart';
class DioHelper
{
static Dio dio;

static init(){

}


static void getCourses(String email, ValueChanged<List<Course>> handler) async {
  FormData form=FormData.fromMap({
    'option': '2', 'email': email
  });
  var response = await Dio().post('http://test.vps51796.mylogin.co/exam_web/exam.php', data: form);
  // print('response :  $response');
  // final parsedJson = jsonDecode(response.toString());
  // print(response.toString());
  // print(";;;;;;;;;;;;;;;");
  // print(parsedJson.toString());
  // print("---------------------");
  var courseObjJson = jsonDecode(response.toString())["courses"] as List;
  List<Course> courseList = courseObjJson.map((courseJson) => Course.fromJson(courseJson)).toList();
  handler(courseList);
}


static void deleteCourse(String email,@required String courseID) async {
  FormData form=FormData.fromMap({
    'option': '3', 'courseid': courseID
  });
  await Dio().post('http://test.vps51796.mylogin.co/exam_web/exam.php', data: form);
}

static void addCourse(String email,@required String coursename) async {
  FormData form=FormData.fromMap({
    'option': '4', 'coursename': coursename,'email':email
  });
  await Dio().post('http://test.vps51796.mylogin.co/exam_web/exam.php', data: form);
}

}
