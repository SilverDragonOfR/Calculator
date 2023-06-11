import 'package:flutter/material.dart';

class History extends StatefulWidget {
  List history;
  Color c1;
  Color c2;
  Color c3;
  Color c4;
  Color c5;
  Color c6;

  History({
    required this.history,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  HistoryState createState() => HistoryState(
      history: history, c1: c1, c2: c2, c3: c3, c4: c4, c5: c5, c6: c6);
}

class HistoryState extends State<History> {
  List history;
  Color c1;
  Color c2;
  Color c3;
  Color c4;
  Color c5;
  Color c6;

  HistoryState({
    required this.history,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  void deleteHistory() {
    setState(() {
      history = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context, history),
          ),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("History", style: TextStyle(fontSize: 30)),
                ElevatedButton(
                    onPressed: () {
                      deleteHistory();
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(color: c1),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: c4))
              ],
            ),
          ),
          backgroundColor: c3,
          foregroundColor: c1,
        ),
        body: Container(
            color: c6,
            child: ListView.separated(
              padding: EdgeInsets.only(top: 50),
              itemBuilder: (context, index) {
                int index_rev = history.length - index - 1;
                if (index_rev == history.length - 1) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${history[index_rev][0]}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.07,
                                color: c1)),
                        Text("= ${history[index_rev][1]}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.10,
                                color: c1))
                      ]);
                } else {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${history[index_rev][0]}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.05,
                                color: c1)),
                        Text("= ${history[index_rev][1]}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.07,
                                color: c1))
                      ]);
                }
              },
              itemCount: history.length,
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 10,
                  endIndent: 10,
                  color: c3,
                );
              },
            )));
  }
}
