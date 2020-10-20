import 'package:prayer_times/model/AlquranModel.dart';
import 'package:http/http.dart' as http;

class AlquranViewModel {
  Future<List> getAlquran() async {
    try {
      http.Response hasil = await http.get(
        Uri.encodeFull('https://al-quran-8d642.firebaseio.com/data.json?print=pretty'),
        headers: {"Accept":"Application/json"}
      );
      if( hasil.statusCode == 200 ) {
        print("fetching data success");
        final data = alquranModelFromJson(hasil.body);
        return data;
      } else {
        print("error fetch data ${hasil.statusCode.toString()}");
        return null;
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}