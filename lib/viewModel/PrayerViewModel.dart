import 'package:prayer_times/model/PrayerModel.dart';
import 'package:http/http.dart' as http;

class PrayerViewModel {
  Future<PrayerModel> getPrayer(String address, String date) async {
    try {
      print(address);
      print(date);
      http.Response hasil = await http.get(
        Uri.encodeFull('https://api.pray.zone/v2/times/day.json?city=$address&date=$date'),
        headers: {"Accept":"Application/json"}
      );
      if( hasil.statusCode == 200 ) {
        print("data success diambil");
        final data = prayerModelFromJson(hasil.body);
        return data;
      } else {
        print("Error get data ${hasil.statusCode.toString()}");
        return null;
      }
    } catch(e) {
      print("error catch $e");
      return null;
    }
  }
}