import 'dart:convert';

import 'package:covid_tracker/models/AllCountriesModel.dart';
import 'package:covid_tracker/models/WorldStatesModel.dart';
import 'package:covid_tracker/services/utils/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesData() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("error.. (can call fetchWorldStatesData api)");
    }
  }

  Future<List<dynamic>> fetchAllCountriesData() async {
    var data;
    print("all countries data api called");
    final response = await http.get(Uri.parse(AppUrl.countriesUrl));
    if (response.statusCode == 200) {
      // allCountiresList.clear();
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("something went wrong(fetchALLCOuntiresData api)");
    }
  }
}
