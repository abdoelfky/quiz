import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constants.dart';
import 'package:quizz_app/models/Course.dart';

class QuizScreen extends StatefulWidget {
  final String name;
  const QuizScreen({this.name}) ;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    List quizNum = List.generate(15, (index) => index+1);
    print(quizNum);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: quizColor,
        title: Text('${widget.name} Course'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder:(context,index)=> Dismissible(
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (_) {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    elevation: 24.0,
                    title: const Text('Are You Sure?'),
                    content: const Text(
                        'You will not be able to recover it'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Delete'),
                        onPressed: () {
                          setState(() {
                            quizNum.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('Cancel'),
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
            },
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            child:buildQuiz(quizNum[index].toString()),),
        itemCount: quizNum.length,
      ),
    );

  }
}
Widget buildQuiz(String number) => InkWell(
  onTap: ()
  {
  },
  child:   Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('quiz_icon.jpg'),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Quiz ${number} ",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
