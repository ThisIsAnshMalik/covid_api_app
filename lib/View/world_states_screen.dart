import 'package:covid_tracker/View/countries_list_screen.dart';
import 'package:covid_tracker/Widgets/custome_row.dart';
import 'package:covid_tracker/models/WorldStatesModel.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa268),
    const Color(0xffde5426),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FutureBuilder(
                future: statesServices.fetchWorldStatesData(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          colorList: colorList,
                          chartType: ChartType.ring,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: MediaQuery.of(context).padding,
                          child: Card(
                            child: Column(
                              children: [
                                CustomeRaw(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString(),
                                ),
                                CustomeRaw(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                CustomeRaw(
                                  title: "Active",
                                  value: snapshot.data!.active.toString(),
                                ),
                                CustomeRaw(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString(),
                                ),
                                CustomeRaw(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                CustomeRaw(
                                  title: "TodayCases",
                                  value: snapshot.data!.todayCases.toString(),
                                ),
                                CustomeRaw(
                                  title: "TodayDeaths",
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return CountriesListScreen();
                            }));
                          }),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Text("Track Contries")),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
