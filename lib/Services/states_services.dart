import 'dart:convert';

import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/Services/Utils/urls.dart';

import 'package:http/http.dart' as http;

import '../Model/countries_states_model.dart';

class States {
  Future<WorldStatesModel> getWorldStates() async {
    final responce = await http.get(Uri.parse(Urls.worldStates));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> getCountriesStates() async {
   
    final responce =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);

      return data;
    } else {
      throw Exception("Error");
    }
  }
}
