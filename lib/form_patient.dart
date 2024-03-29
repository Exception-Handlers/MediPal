import 'package:flutter/material.dart';
import 'package:medipal/forms/general_info.dart';
import 'package:medipal/forms/health_conditions.dart';

class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  int _pageIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _pages = [
    GeneralInfoForm(),
    HealthConditionsForm(),
    NextForm(),
  ];

  void _nextPage() {
    setState(() {
      if (_pageIndex < _pages.length - 1) {
        _pageIndex++;
        _pageController.animateToPage(
          _pageIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_pageIndex > 0) {
        _pageIndex--;
        _pageController.animateToPage(
          _pageIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF6D98EB), // Light blue at the bottom
              Color(0xFFBAA2DA), // Purple at the top
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                children: _pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _previousPage,
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NextForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Next Form'),
    );
  }
}