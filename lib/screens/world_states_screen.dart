import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat();

  States states = States();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FutureBuilder(
              future: states.getWorldStates(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString())
                        },
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        animationDuration: const Duration(milliseconds: 800),
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        colorList: const [
                          Colors.blue,
                          Colors.greenAccent,
                          Colors.redAccent,
                        ],
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                          chartValueBackgroundColor: Colors.transparent,
                          chartValueStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableDataRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString()),
                              ReusableDataRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              ReusableDataRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              ReusableDataRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              ReusableDataRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString()),
                              ReusableDataRow(
                                  title: "Today Deaths",
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableDataRow(
                                  title: "Today Recovered",
                                  value:
                                      snapshot.data!.todayRecovered.toString())
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Track Countires")),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReusableDataRow extends StatelessWidget {
  const ReusableDataRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title),
            Text(value),
          ]),
          const SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
