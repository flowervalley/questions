import 'package:flutter/material.dart';
import 'package:questions/course.dart';
import 'package:questions/models.dart';
import 'package:questions/storage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Course>> coursesFuture = Storage.getCourses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => goToCourse(Course()),
          )
        ],
      ),
      body: FutureBuilder(
        future: coursesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if (snapshot.hasData) {
            List<Course> courses = snapshot.data;
            return ListView.builder(
              itemBuilder: (_, i) => ListTile(
                title: Text(courses[i].title),
                onTap: () => goToCourse(courses[i]),
              ),
              itemCount: courses.length,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  /// Navigate to the course widget and
  /// reload the course list after returning from it.
  Future<void> goToCourse(Course course) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CourseWidget(course)),
    );
    coursesFuture = Storage.getCourses();
    setState(() {});
  }
}
