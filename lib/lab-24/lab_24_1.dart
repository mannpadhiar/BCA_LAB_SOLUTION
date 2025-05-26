import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Country-State-City Dropdown')),
      body: CountryStateCityDropdown(),
    ),
  ));
}

class CountryStateCityDropdown extends StatefulWidget {
  @override
  _CountryStateCityDropdownState createState() => _CountryStateCityDropdownState();
}

class _CountryStateCityDropdownState extends State<CountryStateCityDropdown> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  List<String> countries = [];
  List<String> states = [];
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  //Fetch countries from API
  Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse('aaaaaaaaaaaaaaaaaa')); // Country API
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        countries = List<String>.from(data);
      });
    }
  }

  //Fetch states based on selected country
  Future<void> fetchStates(String country) async {
    final response = await http.get(Uri.parse('aaaaaaaaaaaaaaaaaa?country=$country')); // State API
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        states = List<String>.from(data);
        selectedState = null;
        selectedCity = null;
        cities = [];
      });
    }
  }

  //Fetch cities based on selected state
  Future<void> fetchCities(String state) async {
    final response = await http.get(Uri.parse('aaaaaaaaaaaaaaaaaa?state=$state')); // City API
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        cities = List<String>.from(data);
        selectedCity = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Country Dropdown
          DropdownButtonFormField<String>(
            value: selectedCountry,
            hint: Text('Select Country'),
            items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountry = value;
              });
              fetchStates(value!);
            },
          ),
          SizedBox(height: 20),

          // State Dropdown
          DropdownButtonFormField<String>(
            value: selectedState,
            hint: Text('Select State'),
            items: states.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (value) {
              setState(() {
                selectedState = value;
              });
              fetchCities(value!);
            },
          ),
          SizedBox(height: 20),

          // City Dropdown
          DropdownButtonFormField<String>(
            value: selectedCity,
            hint: Text('Select City'),
            items: cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
