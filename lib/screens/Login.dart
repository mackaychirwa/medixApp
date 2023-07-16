import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../classes/api/authentication.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import '../widgets/bottom_nav.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _medixController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // this is for biometrics
  final LocalAuthentication auth = LocalAuthentication();
  // _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  String? id;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: false,
        sensitiveTransaction: true,
        biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 40.0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 10, top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: TextFormField(
                        controller: _medixController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          labelText: "Medix ID",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value){
                          if(value!.isEmpty)
                          {
                            return "Please enter Medix ID";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: 20,
                          ),
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value){
                          if(value!.isEmpty)
                            {
                              return "Please enter password";
                            }
                          return null;
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                // if(_formKey.currentState!.validate())
                                // {
                                //   loginUser(context, '1', _medixController.text, _passwordController.text);
                                //   print("successful");

                                // } else {
                                //   print("did not work");
                                // }
                                Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) =>
                                          const BottomNav()), (Route<dynamic> route)=> false);
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: const Center(
                          child: Image(
                            image: AssetImage("assets/images/finger.png"),
                            height: 200,
                          ),
                        ),
                      ),
                      onTap: () async {
                        if(_formKey.currentState!.validate())
                        {

                            await _authenticateWithBiometrics();
                            await loginUser(context, id!, _medixController.text, _passwordController.text);
                          print("successful");
                        } else {
                          print("did not work");
                        }


                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future registrationUser() async {
    var api = "http://192.168.1.162/api/registerapi.php";

    Map mapdata = {
      'email': _medixController.text,
      'fullname': 'James Chirwa',
      'username': 'Jamie',
      'password': _passwordController.text,
      'mobile': '+265881315201',
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(api), body: mapdata);
    var data = json.encode(response.body);
    //var data = jsonDecode(response.body);
    print("DATA: $data");
    }
  }



