import 'package:flutter/material.dart';
import 'package:prayer_times/viewModel/AyatViewModel.dart';

class DetailAlquran extends StatefulWidget {
  final String nomor;
  final String nama;

  DetailAlquran({this.nomor, this.nama});
  @override
  _DetailAlquranState createState() => _DetailAlquranState();
}

class _DetailAlquranState extends State<DetailAlquran> {
  List dataAyat = List();
  void getAyat() {
    AyatViewModel().getAyat(widget.nomor).then((value) {
      setState(() {
        dataAyat = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAyat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.nama}"),
      ),
      body: dataAyat == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: dataAyat.length,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                      title: Container(
                    padding: EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(dataAyat[i].ar ?? ""),
                        Container(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          dataAyat[i].id ?? "",
                          style: TextStyle(fontSize: 8),
                          textAlign: TextAlign.end,
                        ),
                        Divider()
                      ],
                    ),
                  )),
                );
              },
            ),
    );
  }
}