import 'package:exam/view/widgets/admin_pages_widgets/add_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../model/exam_model.dart';
import '../../../utilites/themes.dart';
import '../../widgets/admin_pages_widgets/exam_questions_screen.dart';
import '../../widgets/admin_pages_widgets/students_score.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({Key? key}) : super(key: key);

  @override
  _ExamDetailsScreenState createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  late int _selectedIndex;
  ExamModel examModel = Get.arguments[0];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Exam Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                buildNavItem(0, 'Questions'),
                buildNavItem(1, 'Students'),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                // Screen 1: Exam Questions
                ExamQuestionsScreen(
                  examModel: examModel,
                ),
                // Screen 2: Students Ordered by Scores
                StudentsOrderedByScoresScreen(  examModel: examModel,),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        height: 45,
        decoration: BoxDecoration(
            color: MAINCOLOR,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withOpacity(0.5))),
        child: MaterialButton(
            onPressed: () {
              Get.defaultDialog(
                  contentPadding: EdgeInsets.zero,
                  titlePadding: EdgeInsets.zero,
                  titleStyle: TextStyle(fontSize: 0),
                  title: '',
                  radius: 10.0,content: AddQuestionWidget(examId: examModel.id));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.queue_play_next,
                  color: WHITE,
                ),
                Text(
                  " add a question",
                  style: TextStyle(
                      color: WHITE, fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildNavItem(int index, String title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    _selectedIndex == index ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.blue : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
