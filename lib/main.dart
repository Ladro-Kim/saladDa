import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/pages/page_add_item.dart';
import 'package:salad_da/pages/page_container.dart';
import 'package:salad_da/pages/page_edit_account.dart';
import 'package:salad_da/pages/page_root.dart';
import 'package:salad_da/pages/page_sign_in.dart';
import 'package:salad_da/pages/page_sign_up.dart';
import 'package:salad_da/provs/provider_background_color.dart';
import 'package:salad_da/provs/provider_bottom_index.dart';
import 'package:salad_da/provs/provider_cart.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/provs/provider_custom_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomIndexProvider()),
        ChangeNotifierProvider(create: (_) => BackgroundColorProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseProvider()),
        ChangeNotifierProvider(create: (_) => CustomUserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          getPages: [
            GetPage(name: "/RootPage", page: () => RootPage()),
            GetPage(
                name: "/SignInPage",
                page: () => SignInPage(),
                transition: Transition.leftToRight,
                transitionDuration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn),
            GetPage(
                name: "/SignUpPage",
                page: () => SignUpPage(),
                transition: Transition.rightToLeft,
                transitionDuration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn),
            GetPage(
                name: "/ContainerPage",
                page: () => ContainerPage(),
                transition: Transition.fade,
                transitionDuration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn),
            GetPage(
                name: "/AddItemPage",
                page: () => AddItemPage(),
                transition: Transition.fade,
                transitionDuration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn),
            GetPage(
                name: "/EditAccountPage",
                page: () => EditAccountPage(),
                transition: Transition.upToDown,
                transitionDuration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn)
          ],
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: "Recursive",
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,
            ),
          ),
          home: RootPage(),
        );
      },
    );
  }
}
