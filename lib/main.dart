import 'package:flutter/material.dart';
// firebase
import 'package:firebase_core/firebase_core.dart'; // firebase core
import 'package:medipal/pages/SignUp.dart';
import 'package:medipal/pages/login.dart';
import 'firebase_options.dart'; // firebase api keys
import 'package:firebase_database/firebase_database.dart'; // realtime database
import 'package:cloud_firestore/cloud_firestore.dart'; // cloud firestore
import 'package:firebase_auth/firebase_auth.dart'; // authentication
import 'package:firebase_analytics/firebase_analytics.dart'; // analytics
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; //
// pages
import 'package:medipal/count.dart';
import 'package:medipal/auth_gate.dart';
import 'package:medipal/form_patient.dart';
import 'package:medipal/pages/forgotpasswd.dart';
import 'package:medipal/pages/SignUp.dart';
import 'package:medipal/pages/login.dart';

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
        '/': (context) => HomePage(),
        '/Count': (context) => Count(),
        '/AuthGate': (context) => AuthGate(),
        '/forgotpasswd': (context) => ForgotAuth(),
        '/Login': (context) => LoginPage(),
        '/SignUp': (context) => SignUpPage(),
        '/Form': (context) => PatientForm(),
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
            ButtonWidget('Count', '/Count'),
            ButtonWidget('AuthGate', '/AuthGate'),
            ButtonWidget('Forgot', '/ForgotAuth'),
            ButtonWidget('Login', '/Login'),
            ButtonWidget('Sign Up', '/SignUp'),
            ButtonWidget('Form', '/Form'),
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
