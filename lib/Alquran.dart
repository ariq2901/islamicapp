import 'package:flutter/material.dart';
import 'package:prayer_times/DetailAlquran.dart';
import 'package:prayer_times/viewModel/AlquranViewModel.dart';

class Alquran extends StatefulWidget {
  @override
  AlquranState createState() => AlquranState();
}

class AlquranState extends State<Alquran> {
  List dataAlquran = List();
  void getListSurat() {
    AlquranViewModel().getAlquran().then((value) {
      setState(() {
        dataAlquran = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getListSurat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alquran"),
      ),
      body: dataAlquran == null
      ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),),) 
      : ListView.builder(
        itemCount: dataAlquran.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(dataAlquran[i].nama),
            subtitle: Text("${dataAlquran[i].arti} | ${dataAlquran[i].ayat} ayat"),
            trailing: Text(dataAlquran[i].asma),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DetailAlquran(
                    nomor: dataAlquran[i].nomor,
                    nama: dataAlquran[i].nama,
                  );
                }
              ));
            },
          );
        },
      )
    );
  }

}