import 'package:flutter/material.dart';
// firebase
import 'package:firebase_core/firebase_core.dart'; // firebase core
import 'package:medipal/chat/chat_list.dart';
import 'package:medipal/pages/home.dart';
import 'package:medipal/pages/user_list.dart';
import 'package:medipal/pages/user_patients.dart';
import 'package:medipal/objects/patient.dart';
import 'package:medipal/pages/appointment_page.dart';
import 'package:medipal/pages/dashboard.dart';
import 'package:medipal/pages/signup.dart';
import 'package:medipal/pages/login.dart';
import 'package:medipal/pages/patient_list.dart';
import 'firebase_options.dart'; // firebase api keys
import 'package:firebase_auth/firebase_auth.dart'; // authentication
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; //
// pages
import 'package:medipal/pages/patient_form.dart';
import 'package:medipal/pages/settings.dart';

void main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // main app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Development Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/Login': (context) => LoginPage(),
        '/SignUp': (context) => SignUpPage(),
        '/PatientForm': (context) => PatientForm(patient: Patient()),
        '/PatientList': (context) => PatientList(),
        '/AppointmentPage': (context) => AppointmentPage(userUid: FirebaseAuth.instance.currentUser!.uid),
        '/Dashboard': (context) => Dashboard(userUid: FirebaseAuth.instance.currentUser!.uid),
        '/UserPatients': (context) =>
            PractitionerPatients(userUid: FirebaseAuth.instance.currentUser!.uid),
        '/ChatList': (context) => ChatList(),
        '/Settings': (context) => SettingsPage(),
        '/Home': (context) => HomeTestPage(),
        '/UserList': (context) => PractitionerList(),

      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute<ProfileScreen>(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              }
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonWidget('Login', '/Login'),
            ButtonWidget('Sign Up', '/SignUp'),
            ButtonWidget('PatientForm', '/PatientForm'),
            ButtonWidget('PatientList', '/PatientList'),
            ButtonWidget('Appointmentpage', '/AppointmentPage'),
            ButtonWidget('Dashboard', '/Dashboard'),
            ButtonWidget('UserPatients', '/UserPatients'),
            ButtonWidget('ChatList', '/ChatList'),
            ButtonWidget('Settings', '/Settings'),
            ButtonWidget('Home', '/Home'),
            ButtonWidget('UserList', '/UserList'),
            /* FirebaseAuth.instance.currentUser != null
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        child: Column(
                      children: [
                        Image.asset('dash.png'),
                        Text(
                          'Welcome!',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SignOutButton(),
                      ],
                    )),
                  )
                : Container(), */
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final String routeName;

  ButtonWidget(this.buttonText, this.routeName);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Text(buttonText),
    );
  }
}
