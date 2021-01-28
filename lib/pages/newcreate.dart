import 'package:flutter/material.dart';

import '../domains/diary.dart';
import '../utils/db.dart';

class CreateDiaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CreateDiaryWidget();
  }
}

class CreateDiaryWidget extends StatefulWidget {
  @override
  _CreateDiaryState createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiaryWidget> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void dispose() {
    this.titleController.dispose();
    this.bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Diary',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white
            )),
      ),

      body: Padding(
        padding: EdgeInsets.all(5.0),
          child: Column(children: [
              Container(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        hintText: '제목'
                    ),
                    controller: this.titleController,
                  )),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '내용'
                    ),
                    controller: this.bodyController,
                  ))
            ])),

      floatingActionButton: FloatingActionButton(
    onPressed: () {
      Diary diary = new Diary(
        title: titleController.text,
        body: bodyController.text,
        updatedAt: DateTime.now());

      DatabaseHelper().createDiary(diary);
      Navigator.pop(context);
    },
    child: Icon(Icons.check, color: Colors.white)));
  }
}