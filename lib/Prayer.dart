import 'package:flutter/material.dart';
import 'package:prayer_times/model/PrayerModel.dart';
import 'package:prayer_times/viewModel/PrayerViewModel.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Prayer extends StatefulWidget {
  @override
  _PrayerState createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  PrayerModel prayerModel;
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _currentAddress;
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager = true;

  void getPrayer(optionalAddress) {
    PrayerViewModel().getPrayer(optionalAddress, date).then((value) {
      if (value == null) {
        getPrayer('Malang');
      } else {
        setState(() {
          prayerModel = value;
        });
      }
    });
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      getPrayer('Malang');
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = place.subAdministrativeArea;
      });
      getPrayer(_currentAddress.split(' ').toList()[1]);
    } catch (e) {
      print(e);
      getPrayer('Malang');
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
        backgroundColor: Colors.green,
      ),
      body: prayerModel == null
      ? Container(
        padding: EdgeInsets.fromLTRB(12.0, 25.0, 12.0, 8.0),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.green, Colors.green[300]])),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),),
                SizedBox(height: 20.0,),
                Text('if it still doesn\'t appear', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                Text('make sure your internet connection and GPS is active', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
              ],
            ),
          ),
      )
      : Container(
          padding: EdgeInsets.fromLTRB(12.0, 25.0, 12.0, 8.0),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.green, Colors.green[300]])),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _currentAddress,
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          date,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    child: Image.network(
                      'https://icons.iconarchive.com/icons/iconsmind/outline/512/Sunrise-icon.png',
                      scale: 8,
                    ),
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    prayerModel.results.datetime[0].times.fajr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.white,
                    size: 65.0,
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    prayerModel.results.datetime[0].times.dhuhr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    child: Image.network(
                      'https://img.icons8.com/ios/452/partly-cloudy-day.png',
                      scale: 7,
                    ),
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    prayerModel.results.datetime[0].times.asr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    child: Image.network(
                      'https://www.shareicon.net/data/2016/07/22/799916_moon_512x512.png',
                      scale: 8,
                    ),
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    prayerModel.results.datetime[0].times.maghrib,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: ColorFiltered(
                      child: Image.network(
                        'https://i.pinimg.com/originals/86/0d/6d/860d6dbc8c8a2f579141d8be2bd5995d.png',
                        scale: 13,
                      ),
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      prayerModel.results.datetime[0].times.isha,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _getCurrentLocation();
        },
        label: Text('Refresh'),
        icon: Icon(Icons.pin_drop),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}

//^ Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(14),
//             margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'Fajr',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   prayerModel.results.datetime[0].times.fajr,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(14),
//             margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'Dhuhr',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   prayerModel.results.datetime[0].times.dhuhr,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(14),
//             margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'Asr',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   prayerModel.results.datetime[0].times.asr,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(14),
//             margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'Maghrib',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   prayerModel.results.datetime[0].times.maghrib,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(14),
//             margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'Isha',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   prayerModel.results.datetime[0].times.isha,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 if (_currentPosition != null) Text(_currentAddress),
//                 FlatButton(
//                   child: Text("Get your current location"),
//                   onPressed: () {
//                     _getCurrentLocation();
//                   },
//                 ),
//                 Text(
//                   'make sure GPS sudah diaktifkan',
//                   style: TextStyle(color: Colors.red, fontSize: 10.0),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     )
