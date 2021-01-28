import 'package:flutter/material.dart';
import 'dart:developer';

import 'pages/newcreate.dart';
import 'utils/db.dart';
import 'domains/diary.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Diary',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'My Diary App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          title: Text(widget.title,
            style: TextStyle(fontSize: 28.0, color: Colors.white)),
        ),
        body: FutureBuilder<List<Diary>>(
          future: DatabaseHelper().getAllDiaries(),
            builder:
            (BuildContext context, AsyncSnapshot<List<Diary>> snapshot) {
            if (!snapshot.hasData) return Center();

            return snapshot.data.length > 0
                ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Diary item = snapshot.data[index];
                  log("item index $index");

                  var formatDateTime =
                  DateFormat('yyyy-MM-dd').format(item.updatedAt);

                  return ListTile(
                    title: Text(item.title, style: TextStyle(fontSize: 18)),
                    subtitle: Text(
                      formatDateTime + ' ' + item.body, style: TextStyle(
                        color: Colors.grey.withOpacity(0.8)),
                      maxLines: 1,
                    ),
                  );
            })
            : Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    (Text("일기장이 비어있어요!",
                        style: TextStyle(color: Colors.grey, fontSize: 20)))
                  ])));
          }),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('일기 쓰기', style: TextStyle(color: Colors.white)),
          tooltip: '오늘의 일기를 남겨요',
          onPressed: () {
            _createDiaryPage(context);
          }));
  }

_createDiaryPage(BuildContext context) async {
    await Navigator.push(
      context, MaterialPageRoute(builder: (context) => CreateDiaryPage()));

    setState(() {});
}

}
