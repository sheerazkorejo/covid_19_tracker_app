import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/countries_states_model.dart';
import 'county_detail_screen.dart';

class CountiresStatesList extends StatefulWidget {
  const CountiresStatesList({super.key});

  @override
  State<CountiresStatesList> createState() => _CountiresStatesListState();
}

class _CountiresStatesListState extends State<CountiresStatesList>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat();

  final TextEditingController _textEditingController = TextEditingController();
  States countiresStates = States();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Search Country Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: countiresStates.getCountriesStates(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                    height: 10, width: 90, color: Colors.white),
                                subtitle: Container(
                                    height: 10, width: 90, color: Colors.white),
                                leading: Container(
                                    height: 50, width: 50, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String countryName = snapshot.data![index]["country"];

                        if (_textEditingController.text.isEmpty) {
                          return   Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen( image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,),)),
                                child: ListTile(
                                  title: Text(snapshot.data![index]["country"]),
                                  subtitle: Text(
                                      snapshot.data![index]["cases"].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ["countryInfo"]["flag"]),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (countryName.toLowerCase().contains(
                            _textEditingController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen( image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,),)),
                                child: ListTile(
                                  title: Text(snapshot.data![index]["country"]),
                                  subtitle: Text(
                                      snapshot.data![index]["cases"].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ["countryInfo"]["flag"]),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
