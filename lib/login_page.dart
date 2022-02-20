import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aplicacion_tcu/home.dart';
import 'package:local_auth/local_auth.dart';
import 'storage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('Ingresar'),
          onPressed: () async {
            bool isAuthenticated =
                await Authentication.authenticateWithBiometrics();

            if (true) {
              //isAuthenticated) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        biometricOnly: true,
      );
    }

    return isAuthenticated;
  }
}