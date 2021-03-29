import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:salad_da/services/sign_in_up_out.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  TextEditingController _idController;
  TextEditingController _passwordController;

  Duration dur = Duration(milliseconds: 1000);

  double opacityValue = 0;

  bool isAutoValidate = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50))
        .then((value) => opacityValue = 1);
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color>(
      tween: ColorTween(begin: Colors.black, end: Colors.white),
      duration: dur,
      curve: Curves.fastOutSlowIn,
      builder: (BuildContext context, Color tween, Widget child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: tween,
            body: Form(
              key: _signInFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    buildTitle(),
                    mainImage(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [
                        idTextFormField(),
                        SizedBox(height: 15),
                        passwordTextFormField(),
                        SizedBox(height: 20),
                        signInButton(context),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                    "assets/images/image_google.png"),
                              ),
                              onTap: () {
                                signInWithGoogle();
                              },
                            ),
                            SizedBox(width: 50),
                            InkWell(
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                    "assets/images/image_apple.jpeg"),
                              ),
                              onTap: () {
                                signInWithApple();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        signUpButton(context),
                        SizedBox(height: 15),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Text buildTitle() {
    return Text(
      "Salad - Da",
      style: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.lime),
    );
  }

  Widget mainImage() {
    return AnimatedOpacity(
      opacity: opacityValue,
      duration: dur + Duration(milliseconds: 2000),
      curve: Curves.easeIn,
      child: Image.asset("assets/images/salad.gif", width: MediaQuery.of(context).size.height * 0.25),
    );
  }

  Widget idTextFormField() {
    return TextFormField(
      controller: _idController,
      decoration: InputDecoration(
        labelText: "E-mail",
        icon: Icon(Icons.supervised_user_circle_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty || !value.contains("@") || !value.contains("."))
          return "Check your email";
        return null;
      },
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        icon: Icon(Icons.lock_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty || value.length < 8) return "Check your password";
        return null;
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return TweenAnimationBuilder(
      duration: dur,
      tween: ColorTween(begin: Colors.black, end: Colors.green),
      builder: (context, tween, child) {
        return TextButton(
          child: Text(
            "Sign In",
            style: TextStyle(color: tween, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (_signInFormKey.currentState.validate())
              signInWithEmail(email: _idController.text, password: _passwordController.text).then((value) {
                switch(value) {
                  case 0:
                    Get.offAndToNamed("/ContainerPage");
                    break;
                  case 1:
                    Get.snackbar("Email Error", "User not found");
                    _idController.text = "";
                    _passwordController.text = "";
                    break;
                  case 2:
                    Get.snackbar("Password Error", "Wrong password");
                    _passwordController.text = "";
                    break;
                  case 3:
                    Get.snackbar("Other Error", "Contact to manager");
                    break;
                }
              });

          },
        );
      },
    );
  }

  Widget signUpButton(BuildContext context) {
    return TweenAnimationBuilder(
      duration: dur,
      tween: ColorTween(begin: Colors.black, end: Colors.blue),
      builder: (context, tween, child) {
        return InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?  ",
                style: TextStyle(color: tween),
              ),
              Text(
                "Sign Up!",
                style: TextStyle(color: tween, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onTap: () {
            Get.toNamed("/SignUpPage");
          },
        );
      },
    );
  }
}
