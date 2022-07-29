import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
static const String id = 'myHomePage';

  MyPage({Key? key, }) : super(key: key);


  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height  * 0.4,
            child: Center(
              child: Text("Welcome to AndroidVille!"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("this is the firdt"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click the floating action button to show bottom sheet.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() =>  displayBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
