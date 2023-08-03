import 'dart:convert';

import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/Services/Utils/urls.dart';
import 'package:http/http.dart' as http;

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
}
