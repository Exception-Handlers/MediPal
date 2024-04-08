import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medipal/objects/patient.dart';
import 'package:medipal/forms/patient_data.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  late List<String> _patientKeys = [];
  late List<Patient> _patients = [];
  late List<Patient> _originalPatients = [];
  late int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPatientData();
  }

  void _fetchPatientData() async {
    // initialize database
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    // get snapshot
    DataSnapshot snapshot = await ref.child('patient').get();
    if (snapshot.value != null) {
      Map<dynamic, dynamic>? jsonMap = snapshot.value as Map<dynamic, dynamic>;
      List<Patient> pl = [];
      jsonMap.forEach((key, value) {
        //print(key);
        print(value);
        Patient p = Patient.fromMap(value);
        //print(p);
        pl.add(p);
        setState(() {
          _currentPageIndex++;
          _patientKeys.add(key);
        });
      });
      setState(() {
        _patients = pl;
        _originalPatients = pl;
      }); // Trigger rebuild to load patient data
    }
  }

  List<Patient> _filterPatients(String searchTerm) {
    // If search term is empty, return the original list
    if (searchTerm.isEmpty) {
      return _originalPatients;
    }
    return _originalPatients.where((patient) {
      String fullName =
          '${patient.firstName ?? ""} ${patient.middleName ?? ""} ${patient.lastName ?? ""}';
      return fullName.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 200, // Adjust the width as needed
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    // Update the UI based on the new search term
                    _patients = _filterPatients(value);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _patients.isNotEmpty
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF6D98EB), // Light blue at the bottom
                    Color(0xFFBAA2DA), // Purple at the top
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                  // Construct the full name with first, middle, and last name
                  String fullName = '${_patients[index].firstName ?? ""} '
                      '${_patients[index].middleName ?? ""} '
                      '${_patients[index].lastName ?? ""}';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Patient ID: ${_patientKeys[index]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    "Name: $fullName",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "DOB: ${_patients[index].dob?.year}/${_patients[index].dob?.month}/${_patients[index].dob?.day}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetPatientData(
                                  patientId: _patientKeys[index],
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
