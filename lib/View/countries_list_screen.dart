import 'package:covid_tracker/View/detail_screen.dart';
import 'package:covid_tracker/models/AllCountriesModel.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: statesServices.fetchAllCountriesData(),
                builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            })));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          String countryName =
                              snapshot.data![index]["country"].toString();
                          if (_searchController.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                            name: snapshot.data![index]
                                                    ["country"]
                                                .toString(),
                                            test: snapshot.data![index]["tests"]
                                                .toString(),
                                            total: snapshot.data![index]
                                                    ["cases"]
                                                .toString(),
                                            image: snapshot.data![index]
                                                    ["countryInfo"]["flag"]
                                                .toString(),
                                            critical: snapshot.data![index]
                                                    ["critical"]
                                                .toString(),
                                            deaths: snapshot.data![index]
                                                    ["deaths"]
                                                .toString(),
                                            recoverd: snapshot.data![index]
                                                    ["recovered"]
                                                .toString(),
                                          )));
                                }),
                                child: ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]["countryInfo"]["flag"]
                                        .toString(),
                                    height: 45,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text(snapshot.data![index]["country"]
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]["cases"]
                                      .toString()),
                                ),
                              ),
                            );
                          } else if (countryName
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                            name: snapshot.data![index]
                                                    ["country"]
                                                .toString(),
                                            test: snapshot.data![index]["tests"]
                                                .toString(),
                                            total: snapshot.data![index]
                                                    ["cases"]
                                                .toString(),
                                            image: snapshot.data![index]
                                                    ["countryInfo"]["flag"]
                                                .toString(),
                                            critical: snapshot.data![index]
                                                    ["critical"]
                                                .toString(),
                                            deaths: snapshot.data![index]
                                                    ["deaths"]
                                                .toString(),
                                            recoverd: snapshot.data![index]
                                                    ["recovered"]
                                                .toString(),
                                          )));
                                }),
                                child: ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]["countryInfo"]["flag"]
                                        .toString(),
                                    height: 45,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text(snapshot.data![index]["country"]
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]["cases"]
                                      .toString()),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }));
                  }
                })),
          )
        ],
      ),
    );
  }
}
