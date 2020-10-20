import 'package:flutter/material.dart';

// Pages
import 'package:prayer_times/Prayer.dart';
import 'package:prayer_times/Alquran.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {

  int _selectedIndex = 0; //! Secara default, navbar yg pertama kali terbuka adalah navbar dengan posisi pertama , yaitu berada di index ke - 0 => 1
  List<Widget> _widgetOptions = <Widget>[ //! nanti, logic yg akan diberikan adalah, jika navbar dengan index ke-1 dipilih -> maka dia akan mengambil list option dengan index ke-1. Begitu juga yg lainnya
    Alquran(),
    Prayer(),
  ];

  void /*! void adalah function yg tidak mempunyai nilai balik */ _onItemTap(int index) {
    setState(() {
      _selectedIndex = index; //! jadi, Setiap kali tombol navbar ditekan, maka dia akan menjalankan function ini, ini akan mengoverride nilai dari _selectedIndex, akan diganti dengan nilai yang diambil dari inputan user
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), //! ini akan mengambil list sesuai index yang ada di variabel _selectedIndex
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Alquran'),
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_builder),
            title: Text('Prayer Time'),
            backgroundColor: Colors.green
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
