import 'package:country_house/screens/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  Future<List> countries;
  bool isSearching = false;

  Future<List> getCountries() async {
    var response = await Dio().get("https://restcountries.eu/rest/v2/all");
    return (response.data);
  }

  @override
  void initState() {
    super.initState();
    this.setState(() {
      countries = getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text('All Countries')
            : TextField(
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
                    });
                  },
                ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List>(
          future: countries,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Country(
                          country: snapshot.data[index],
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
                        snapshot.data[index]['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
