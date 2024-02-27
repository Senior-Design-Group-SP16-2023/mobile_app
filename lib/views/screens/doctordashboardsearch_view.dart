import 'package:flutter/material.dart';
import 'doctordashboarduser_view.dart'; // Make sure the import path is correct
import '../widgets/dashboard_header.dart'; // Adjust the path as necessary

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> _allPatients = [
    // Your list of patients
    'Alex Johnson',
    'Amelia Earhart',
    'Bradley Hughes',
    'Catherine Smith',
    'Charlie Brown',
    'Dennis Brown',
    'Emily Davis',
    'Ethan Hunt',
    'Fiona Wilson',
    'George Clark',
    'Hannah Miller',
    'Ian Moore',
    'Isabella Wright',
    'Julie Taylor',
    'Jack Sparrow',
    'Kevin White',
    'Liam Neeson',
    'Mia Wong',
    'Nathan Drake',
    'Olivia Smith',
    'Pamela Jones',
    'Quentin Tarantino',
    'Rachel Green',
    'Steven King',
    'Tom Holland',
    'Ursula Monroe',
    'Vivian Darkbloom',
    'Walter White',
    'Xander Cage',
    'Yvonne Strahovski',
    'Zachary Levi',
  ];

  List<String> _filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredPatients = _allPatients.where((patient) => patient.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    });
  }

  Widget _alphabetScroll(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 175),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((String letter) {
          return GestureDetector(
            child: Text(letter, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
            onTap: () {
              int index = _filteredPatients.indexWhere((patient) => patient.toUpperCase().startsWith(letter));
              if (index != -1) {
                double position = index * 60.0; // You may need to adjust this value
                _scrollController.animateTo(position, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DashboardHeader(),
                  ),
                  SizedBox(height: 20.0), // Add small space between header and search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search Patients',
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0), // Add small space between header and search bar
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: _filteredPatients.length,
                      itemBuilder: (context, index) {
                        final patient = _filteredPatients[index];
                        return ListTile(
                          title: Text(patient),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailPage(userName: patient))),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(), // Add horizontal line between each item
                    ),
                  ),
                ],
              ),
            ),
            _alphabetScroll(context),
          ],
        ),
      ),
    );
  }
}
