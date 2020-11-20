import 'package:flutter/material.dart';
import 'package:hello_world/pages/ContentPage.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  var data;

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var drawer;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  fetchData() async {
    String res =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    widget.data = jsonDecode(res);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print("open");
    if (widget.data != null)
      print("Data exists.");
    else {
      print("fetching");
      fetchData();
    }
  }

  getNotes() {
    return widget.data == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                drawer = MyDrawer(data: widget.data[index]["sections"]);
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(int.parse(widget.data[index]["color"])),
                  // color: Colors.purple,/
                ),
                child: Center(
                    child: Text(
                  widget.data[index]["note_title"],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   child: Text('$index'),
                    // ),
                    ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 1.7 : 1.1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
  }

  @override
  Widget build(BuildContext context) {
    Future(() {
      // Scaffold.of(context).openDrawer();
      scaffoldKey.currentState.openDrawer();
    });
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("My Journel"),
      ),
      drawer: drawer,
      body: getNotes(),
      // Container(
      //   child: FlutterLogo(
      //       size: MediaQuery.of(context).size.width / 2,
      //     ),
      // ),
    );
  }
}

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  var data;

  MyDrawer({Key key, @required this.data}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var url = "http://jsonplaceholder.typicode.com/photos";
  @override
  void initState() {
    super.initState();
    print("open");
  }

  @override
  void dispose() {
    print("close");
    super.dispose();
  }

  getList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 40),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(12),
          tileColor: index % 2 == 0 ? Colors.blue[200] : Colors.blue[100],
          onTap: () {
            // dispose();
            Navigator.popUntil(context, ModalRoute.withName('/'));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContentPage(
                        drawer: widget,
                        contentJson: widget.data[index]["data"])));
          },
          title: Text(widget.data[index]["title"]),
          subtitle: Text("ID: ${widget.data[index]["id"]}"),
          leading: Text(widget.data[index]["data"]["type"]),
        );
      },
      itemCount: widget.data.length > 100 ? 100 : widget.data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: getList(),
    );
  }
}
