import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:quizz_app/Course.dart';
import 'package:quizz_app/cubit/cubit.dart';
import 'package:quizz_app/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  var titleController=TextEditingController();
  final List myList = List.generate(3, (index) {
    return {"id": index+1, "title": "Product #$index", "price": index + 1};
  });
  var x;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit,CoursesStates>(
      listener:(context,state)
      {
        // if(state is ShopLoadingState)
        // {
        //   x=1;
        // }
        if(state is ShopSuccessState)
        {
          x=2;
        }
      } ,
      builder:(context,state){

        var cubit=CoursesCubit.get(context);

        return
          Scaffold(
                appBar: AppBar(
                  title: const Text("All Courses"),
                ),
                body: SingleChildScrollView(

                  physics: const BouncingScrollPhysics(),
                  child: ConditionalBuilder(
                    condition: cubit.allCourses.isNotEmpty,
                    builder:(context)=> ListView.builder(
                      itemCount: cubit.allCourses.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:(context,index)
                      {
                        return
                          Dismissible(
                              background: Container(
                                alignment: AlignmentDirectional.centerEnd,
                                color:Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(Icons.delete,color: Colors.white,),
                                ),
                              ),
                              onDismissed: (_) {
                                setState(() {
                                  cubit.allCourses.removeAt(index);
                                });
                              },
                              direction: DismissDirection.endToStart,
                              key: UniqueKey(),
                              child:buildItems(cubit.allCourses,index)
                          );

                      },
                    ),
                    fallback: (context)=> Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Center(child:const Text('Please Add Course',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),)),
                    )
                    ),
                  ),
                floatingActionButton:FloatingActionButton(onPressed:(){
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          width: 260.0,
                          height: 130.0,
                          decoration:  BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color(0xFFFFFF),
                            borderRadius:
                            BorderRadius.all( Radius.circular(32.0)),
                          ),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              // dialog top
                              Row(
                                children: <Widget>[
                                  Container(
                                    // padding: new EdgeInsets.all(10.0),
                                    decoration:  const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child:  const Text(
                                      'Course Name',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'helvetica_neue_light',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              // dialog centre
                              TextFormField(
                                controller: titleController,
                                decoration:  InputDecoration(
                                  border:const UnderlineInputBorder() ,
                                  filled: false,
                                  contentPadding:  const EdgeInsets.only(
                                      left: 10.0,
                                      top: 10.0,
                                      bottom: 10.0,
                                      right: 10.0),
                                  hintText: 'Course Name',
                                  hintStyle:  TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12.0,
                                    fontFamily: 'helvetica_neue_light',
                                  ),
                                ),
                              ),
                              // dialog bottom
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: TextButton(
                                          onPressed: () { Navigator.pop(context); },
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration:  const BoxDecoration(
                                              color: Colors.red,
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontFamily: 'helvetica_neue_light',
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              cubit.allCourses.add(Course(id: "3", name:'${titleController.text}'));
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration:  const BoxDecoration(
                                              color: Color(0xFF33b17c),
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontFamily: 'helvetica_neue_light',
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                  child: Icon(Icons.add),),
              );


      }

    );
  }
}


Widget buildItems(List<Course> model,index)=>Card(
  child:   Padding(

    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),

    child:Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(''),
        ),
        SizedBox(width: 16.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model[index].name}',
                style: const TextStyle(fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5.0,),
              Row(
                children:[
                  Expanded(
                    child: Text(
                      'ID : ${model[index].id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
             ),
            ],
         ),
        ),
     ],
   ),
  ),
);
