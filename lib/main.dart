import 'package:flutter/material.dart';
import 'modules/InstructorHome.dart';
import 'network/local/cash_helper.dart';
import 'package:quizz_app/cubit/cubit.dart';
import 'network/remote/dio_helper.dart';
import 'modules/home_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CoursesCubit()..getData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: HomeLayout()
      ),
    );
  }
}
