import 'package:quizz_app/cubit/states.dart';
import 'package:quizz_app/dio_helper.dart';
import 'package:quizz_app/model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesCubit extends Cubit<CoursesStates> {
  CoursesCubit() : super(CoursesInitialState());

  static CoursesCubit get(context) => BlocProvider.of(context);



  CoursesModel model;
  void getDate() {
    emit(ShopLoadingState());
   DioHelper.getData(url: 'exam.php').then((value) {
     model = CoursesModel.fromJson(value.data);
     print(model.toString());
     emit(ShopSuccessState());
   }).catchError((onError) {
     print(onError);
     emit(ShopErrorState());
   });
   
  }

}
