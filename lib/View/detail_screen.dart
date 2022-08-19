import 'package:covid_tracker/Widgets/custome_row.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, recoverd, deaths, total, critical, test, image;
  DetailScreen(
      {Key? key,
      required this.image,
      required this.critical,
      required this.deaths,
      required this.name,
      required this.recoverd,
      required this.test,
      required this.total})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                    child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  CustomeRaw(title: "cases", value: widget.total),
                  CustomeRaw(title: "Recoverd", value: widget.recoverd),
                  CustomeRaw(title: "Deaths", value: widget.deaths),
                  CustomeRaw(title: "Tests", value: widget.test),
                  CustomeRaw(title: "Critical", value: widget.critical),
                  // CustomeRaw(title: "cases", value: widget.total),
                ])),
              ),
              Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
