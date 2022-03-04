import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class DioHelper
{
static Dio dio;

static init(){
  dio =Dio(
    BaseOptions(
      baseUrl: 'http://test.vps51796.mylogin.co/exam_web/exam.php',
      receiveDataWhenStatusError: true,
      connectTimeout:60*1000 ,
      receiveTimeout:60*1000 ,
    ),
  );
}


static Future <Response> getData(
    {
      @required String url,
      String option='2',
      String email='amro43210@gmail.com'
    })async
{
  dio.options.headers=
  {
    'option':option,
    'email':email,

  };


  return dio.post(url);

}
}
