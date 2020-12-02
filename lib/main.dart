import 'package:flutter/material.dart';
import 'dart:async';
import 'toon.dart';
import 'helper.dart';

void main() => runApp(
      MaterialApp(
        home: Home(
          title: 'Toon Navigation demo home page',
          toons: new Helper().fetchStudents(),
        ),
      ),
    );

class Home extends StatelessWidget {
  final String title;
  final Future<List<Toon>> toons;

  Home({Key key, this.title, this.toons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Toons by Jay Han")),
          backgroundColor: Colors.grey[850],
        ),
        backgroundColor: Colors.grey[900],
        body: Center(
          child: FutureBuilder<List<Toon>>(
            future: toons,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? StudentBoxList(items: snapshot.data)

                  // return the ListView widget :

                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

class StudentBoxList extends StatelessWidget {
  final List<Toon> items;

  StudentBoxList({Key key, this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ToonBox(item: items[index]),
        );
      },
    );
  }
}

class ToonBox extends StatelessWidget {
  ToonBox({Key key, this.item}) : super(key: key);
  final Toon item;

  Expanded firstExpanded() {
    return Expanded(
      child: Center(
        child: Text(
          this.item.toonId,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
      ),
    );
  }

  Expanded secondExpanded() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Image.network(
          this.item.pictureUrl,
          width: 50.0,
        ),
      ),
    );
  }

  Expanded lastExpanded() {
    return Expanded(
      flex: 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "${this.item.firstName} ${this.item.lastName}",
              style: TextStyle(color: Colors.deepOrange),
            ),
            Text(
              this.item.occupation,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          color: Colors.grey[800],
          child: Row(children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    firstExpanded(),
                    secondExpanded(),
                    lastExpanded(),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
