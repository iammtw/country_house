import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Country extends StatelessWidget {
  final Map country;

  Country({this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(country['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            OurCard(
              title: "Capital",
              value: country['capital'],
              backColor: Colors.amber,
            ),
            OurCard(
              title: "Population",
              value: country['population'].toString(),
              backColor: Colors.blueAccent,
            ),
            FlipCard(
              front: CountryCard(title: "Flag"),
              back: Card(
                color: Colors.white,
                child: Center(
                  child: SvgPicture.network(country['flag']),
                ),
              ),
            ),
            OurCard(
              title: "Currency",
              value: country['currencies'][0]['name'],
              backColor: Colors.deepPurple,
            ),
            // CountryCard(title: "Show on Map"),
          ],
        ),
      ),
    );
  }
}

class OurCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backColor;

  OurCard({this.title, this.value, this.backColor});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: CountryCard(title: title),
      back: ValueCard(value: value, color: backColor),
    );
  }
}

class ValueCard extends StatelessWidget {
  final String value;
  final Color color;
  ValueCard({this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  CountryCard({this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
