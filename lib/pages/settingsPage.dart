import 'package:flutter/material.dart';
import 'package:medipal/constant/images.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF6D98EB), // Light blue at the bottom
                    Color.fromARGB(255, 192, 212, 248), // White at top
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50, // Fixed width for back arrow
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.black, size: 40),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          myImage,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        SizedBox(width: 25),
                        Image.asset(
                          'assets/cog.png',
                          fit: BoxFit.contain,
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(
                          width: 7,
                        ), // Add some space between the image and the text
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 3),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              FractionallySizedBox(
                                widthFactor: 1.0,
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 684.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 25.0),
                                          height: 420.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF6589e3),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          10.0), // Add 10 pixels of padding to the left side
                                                  child: Text(
                                                    'Preferences',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF7f97ed),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0),
                                                ),
                                                child: ListTile(
                                                  trailing: Image.asset(
                                                      'assets/arrow.png'),
                                                  title: Text(
                                                    'Language and Region',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    // Navigate to Account settings page
                                                  },
                                                ),
                                              ),
                                              // Add other ListTile widgets for settings
                                              Container(
                                                margin: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF7f97ed),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0),
                                                ),
                                                child: ListTile(
                                                  trailing: Image.asset(
                                                      'assets/arrow.png'),
                                                  title: Text(
                                                    'Account',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'Email, Password Change',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    // Navigate to Security settings page
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF7f97ed),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0),
                                                ),
                                                child: ListTile(
                                                  trailing: Image.asset(
                                                      'assets/arrow.png'),
                                                  title: Text(
                                                    'Security',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'Privacy Settings for Patient Data Access',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    // Navigate to Security settings page
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF7f97ed),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0),
                                                ),
                                                child: ListTile(
                                                  trailing: Image.asset(
                                                      'assets/arrow.png'),
                                                  title: Text(
                                                    'Notifications',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    // Navigate to Security settings page
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                65), // Added space between boxes
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1f56de),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              'Logout',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30.0,
                                              ),
                                            ),
                                            onTap: () {
                                              // Handle logout action
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
