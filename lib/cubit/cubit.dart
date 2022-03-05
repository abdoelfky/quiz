import '../models/Course.dart';
import '../modules/InstructorServices.dart';
import 'package:quizz_app/cubit/states.dart';
import '../network/remote/dio_helper.dart';
import '../models/model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesCubit extends Cubit<CoursesStates> {
  CoursesCubit() : super(CoursesInitialState());

  static CoursesCubit get(context) => BlocProvider.of(context);



  List<Course> allCourses=List.empty();



void getData(){
  allCourses=[];
  emit(ShopGetDataLoadingState());
  DioHelper.getCourses('amro43210@gmail.com', (value)
  {

  allCourses = value;
    emit(ShopGetDataSuccessState());
  });
}
void deleteCourse(courseID){
    emit(ShopDeleteLoadingState());
    DioHelper.deleteCourse('amro43210@gmail.com',courseID);
    // allCourses=[];
    getData();
    emit(ShopDeleteSuccessState());
  }

void addCourse(courseName){
    emit(ShopAddLoadingState());
    DioHelper.addCourse('amro43210@gmail.com',courseName);
    // allCourses=[];
    getData();
    emit(ShopAddSuccessState());
  }
}



