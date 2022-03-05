import 'package:flutter/material.dart';

class Course {
  String id;
  String name;

  Course({@required this.id,@required this.name});

  factory Course.fromJson(Map<String, dynamic> json){
    final id = json['id'] as String;
    final name = json['name'] as String;
    return Course(id: id, name: name);
  }

  // method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  void display(){
    print("state = ${id}");
    print("msg = ${name}");
  }
}