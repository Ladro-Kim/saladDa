import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/models/custom_user.dart';
import 'package:salad_da/provs/provider_background_color.dart';
import 'package:salad_da/provs/provider_bottom_index.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/provs/provider_custom_user.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  Color iconColor = Colors.pinkAccent;

  @override
  Widget build(BuildContext context) {
    FirebaseProvider firebaseProfiver =
        Provider.of<FirebaseProvider>(context, listen: false);
    CustomUserProvider customUserProvider =
        Provider.of<CustomUserProvider>(context, listen: false);
    User user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection("Users").doc(user.email).get().then((value){
      if(value.data() == null) {
        customUserProvider.customUser = CustomUser(
          name: user.displayName == null ? "null" : user.displayName,
          email: user.email,
          contact: user.phoneNumber == null ? "null" : user.phoneNumber,
          address: "null",
          favorites: <String>[],
        );
        customUserProvider.setCustomUser();
      }
    });

    firebaseProfiver
        .getItems()
        .then((value) => customUserProvider.getCustomUser());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Provider.of<BackgroundColorProvider>(context).color,
        body: Provider.of<BottomIndexProvider>(context).page,
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.black,
        ),
        child:
            Consumer<BottomIndexProvider>(builder: (context, provider, child) {
          return BottomNavigationBar(
            elevation: 4,
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            currentIndex: provider.currentIndex,
            selectedItemColor: iconColor,
            unselectedItemColor: Colors.white24,
            items: provider.items,
            onTap: (index) {
              switch (index) {
                case 0:
                  iconColor = Colors.pinkAccent;
                  break;
                case 1:
                  iconColor = Colors.blueAccent;
                  break;
                case 2:
                  iconColor = Colors.orangeAccent;
                  break;
                case 3:
                  iconColor = Colors.redAccent;
                  break;
                case 4:
                  iconColor = Colors.greenAccent;
                  break;
              }
              provider.ChangeIndex(index);
            },
          );
        }),
      ),
    );
  }
}
