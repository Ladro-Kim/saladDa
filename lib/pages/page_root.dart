import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salad_da/pages/page_container.dart';
import 'package:salad_da/pages/page_sign_in.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done || snapshot.hasData) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: ContainerPage());
        }
        else {
          return SignInPage();
        }
      }
    );
  }
}

