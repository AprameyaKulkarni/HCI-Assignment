import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  final drawer;
  final contentJson;
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ContentPage({Key key, @required this.drawer, @required this.contentJson})
      : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  // SnackBar savedSnackBar = const SnackBar(content: Text('Saved'));
  // widget.scaffoldKey.currentState.showSnackBar(savedSnackBar);
  bool editmode = false;

  editmodeToggle() {
    if (editmode == true) {
      editmode = false;
    } else
      editmode = true;
    setState(() {});
  }

  Widget getContent() {
    var obj = widget.contentJson;
    return Center(
      child: Text(obj["text"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A Topic"),
        actions: [
          editmode
              ? IconButton(
                  icon: Icon(Icons.save_alt),
                  tooltip: 'Save Changes',
                  onPressed: editmodeToggle,
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit Content',
                  onPressed: editmodeToggle)
        ],
      ),
      drawer: widget.drawer,
      body: getContent(),
    );
  }
}
