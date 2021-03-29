import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/services/sign_in_up_out.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: [
          profileCard(context),
          Column(
            children: [
              TextButton(
                child: Text("Add Item(Only for manager)", style: TextStyle(color: Colors.blueAccent)),
                onPressed: () {
                  Get.toNamed("/AddItemPage");
                },
              ),
              TextButton(
                child: Text("Purchase history", style: TextStyle(color: Colors.blueAccent)),
                onPressed: () {},
              ),
              TextButton(
                child: Text("Contact", style: TextStyle(color: Colors.blueAccent)),
                onPressed: () async {
                  String url = "010-6753-3201";
                  if (await canLaunch(url)) {
                    setState(() async {
                      await launch("tel: $url");
                    });
                  }
                },
              ),
              TextButton(
                child: Text("Log out", style: TextStyle(color: Colors.blueAccent)),
                onPressed: () {
                  // Navigator.pop(context);
                  signOutWithGoogle();
                },
              ),
              TextButton(
                child: Text("GetTestButton", style: TextStyle(color: Colors.blueAccent)),
                onPressed: () {
                  // Navigator.pop(context);
                  Provider.of<FirebaseProvider>(context, listen: false).getItems();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: MediaQuery.of(context).size.width * 0.2,
                    backgroundImage:
                    currentUser.photoURL != null
                        ? NetworkImage(currentUser.photoURL)
                        : AssetImage("assets/images/dummy_image.png"),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 70),
                        currentUser.displayName != null
                            ? Text("${currentUser.displayName}")
                            : Text("Edit user name"),
                        currentUser.email != null
                            ? Text("${currentUser.email}")
                            : Text("Edit user email"),
                        Text("address"),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Get.toNamed("/EditAccountPage");
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
