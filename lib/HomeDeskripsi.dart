import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'DBHelper.dart';
import 'entryformDeskripsi.dart';
import 'Deskripsi.dart';

//pendukung program asinkron
class HomeDeskripsi extends StatefulWidget {
  @override
  HomeDeskrispiState createState() => HomeDeskrispiState();
}

class HomeDeskrispiState extends State<HomeDeskripsi> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Deskripsi> DeskripsiList;
  @override
  Widget build(BuildContext context) {
    updateListView();
    if (DeskripsiList == null) {
      DeskripsiList = List<Deskripsi>();
    }
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Item"),
              onPressed: () async {
                var Deskripsi = await navigateToEntryForm(context, null);
                if (Deskripsi != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertDeskripsi(Deskripsi);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Deskripsi> navigateToEntryForm(
      // ignore: non_constant_identifier_names
      BuildContext context,
      Deskripsi Deskripsi) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(Deskripsi);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.DeskripsiList[index].id.toString() +
                  "-" +
                  this.DeskripsiList[index].jamTayang,
              style: textStyle,
            ),
            subtitle: Text(this.DeskripsiList[index].deskripsi.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                dbHelper.deleteDeskripsi(this.DeskripsiList[index].id);
                updateListView();
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
              },
            ),
            onTap: () async {
              var Deskripsi =
                  await navigateToEntryForm(context, this.DeskripsiList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              int result = await dbHelper.updateDeskripsi(Deskripsi);
              if (result > 0) {
                updateListView();
              }
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Deskripsi>> itemListFuture = dbHelper.getDeskripsiList();
      itemListFuture.then((DeskripsiList) {
        setState(() {
          this.DeskripsiList = DeskripsiList;
          this.count = DeskripsiList.length;
        });
      });
    });
  }
}
