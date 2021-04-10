import 'package:country_house/screens/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  getCountries() async {
    var response = await Dio().get("https://restcountries.eu/rest/v2/all");
    return (response.data);
  }

  @override
  void initState() {
    super.initState();
    getCountries().then((data) => this.setState(() {
          countries = filteredCountries = data;
        }));
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text('All Countries')
            : TextField(
                onChanged: (val) {
                  _filterCountries(val);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search Country Here",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          !isSearching
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    this.setState(() {
                      this.isSearching = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    this.setState(() {
                      this.isSearching = false;
                      filteredCountries = countries;
                    });
                  },
                ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredCountries.length > 0
            ? ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Country(
                            country: filteredCountries[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text(
                          filteredCountries[index]['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
