import 'package:prayer_times/model/AyatModel.dart';
import 'package:http/http.dart' as http;

class AyatViewModel {
  Future<List> getAyat(String nomor) async {
    try {
      print(nomor);
      http.Response hasil = await http.get(
          Uri.encodeFull(
              "https://al-quran-8d642.firebaseio.com/surat/$nomor.json?print=pretty"),
          headers: {"Accept": "Application/json"});
      if (hasil.statusCode == 200) {
        print("Data Ayat SUKSES!");
        final data = ayatModelFromJson(hasil.body);
        return data;
      } else {
        print("Error Status ${hasil.statusCode.toString()}");
        return null;
      }
    } catch (e) {
      print("Error Catch $e");
      return null;
    }
  }
}