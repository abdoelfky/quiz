
import 'package:flutter/material.dart';
import '../models/Course.dart';
import '../models/Dialogs.dart';
import 'InstructorServices.dart';

class InstructorHome extends StatefulWidget {
  final String email;
  InstructorHome({Key key, @required this.email}) : super(key: key);

  @override
  _InstructorState createState() => _InstructorState();
}

class _InstructorState extends State<InstructorHome> {
  bool loaded = false;
  List<Course> allCourses = List.empty();
  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  void loadCourses() async {
    //Dialogs.showLoadingDialog(context, _keyLoader);
    InstructorServices.getCourses(widget.email, (courses) {
      allCourses = courses;
      setState(() {
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      loadCourses();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Courses'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refreshData();
        },
        child: getListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Dialogs.showTextInputDialog(context, "Course Name", (value) {
            print(value);
            setState(() {
              allCourses.add(Course(id: "3", name: value));
            });
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  void refreshData() {
    loadCourses();
  }

  Widget getListView() {
    if (!loaded) {
      return const Center(
        child: Text("Loading Courses..."),
      );
    } else if (allCourses.isEmpty) {
      return const Center(
        child: Text("Please add some Courses"),
      );
    } else {
      return ListView.builder(
        itemCount: allCourses.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              setState(() {
                allCourses.removeAt(index);
              });
            },
            child: Card(
                child: ListTile(
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(allCourses[index].name + ' pressed!'),
                      ));
                    },
                    title: Text(allCourses[index].name),
                    subtitle: Text(allCourses[index].name),
                    leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                    trailing: Icon(icons[0]))),
            background: Container(
              color: Colors.red,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
        },
      );
    }
  }
}
