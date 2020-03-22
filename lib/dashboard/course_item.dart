import 'package:flutter/material.dart';

import 'package:questions/answer.dart';
import 'package:questions/course.dart';
import 'package:questions/models.dart';
import 'package:questions/storage.dart';

class CourseItem extends StatelessWidget {
  final Course course;
  final Color color;

  CourseItem(this.course, this.color);

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CourseWidget(course)),
          ),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 8),
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(course.title, style: TextStyle(fontSize: 18)),
                buildAnswerFutureBuilder()
              ],
            ),
          ),
        ),
      );

  Widget buildAnswerFutureBuilder() => FutureBuilder(
        future: Storage.getQuestionsToAnswer(course),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QuestionToAnswer> qs = snapshot.data;
            if (qs.isNotEmpty) return buildAnswerButton(context, qs);
            return const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            );
          }
          return Container();
        },
      );

  Widget buildAnswerButton(
    BuildContext context,
    List<QuestionToAnswer> qs,
  ) =>
      RaisedButton(
        child: Text(qs.length.toString(), style: const TextStyle(fontSize: 20)),
        color: color,
        colorBrightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AnswerScreen(qs)),
        ),
      );
}
