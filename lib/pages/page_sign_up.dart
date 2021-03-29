import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:salad_da/services/sign_in_up_out.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController _idController;
  TextEditingController _passwordController;
  TextEditingController _passwordCheckController;

  Duration dur = Duration(milliseconds: 1000);

  double opacityValue = 0;

  bool isAutoValidate = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50))
        .then((value) => opacityValue = 1);
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordCheckController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
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
              key: _signUpFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    buildTitle(),
                    SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [
                        idTextFormField(),
                        SizedBox(height: 15),
                        passwordTextFormField(),
                        SizedBox(height: 20),
                        passwordCheckTextFormField(),
                        SizedBox(height: 20),
                        signUpButton(context),
                        SizedBox(height: 15),
                        signInButton(context),
                        SizedBox(height: 20),
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
      duration: dur,
      curve: Curves.easeIn,
      child: Image.asset("assets/images/salad.gif", fit: BoxFit.fitHeight),
    );
  }

  Widget idTextFormField() {
    return TextFormField(
      controller: _idController,
      decoration: InputDecoration(
        labelText: "E-mail",
        icon: Icon(Icons.supervised_user_circle_rounded),
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
      ),
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty || value.length < 8) return "Check your password";
        return null;
      },
    );
  }

  Widget passwordCheckTextFormField() {
    return TextFormField(
      controller: _passwordCheckController,
      decoration: InputDecoration(
        labelText: "Password again",
        icon: Icon(Icons.lock_rounded),
      ),
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty || value.length < 8) {
          return "Check your password";
        } else if (value != _passwordController.text) {
          return "The password is not matching";
        }
        return null;
      },
    );
  }

  Widget signUpButton(BuildContext context) {
    return TweenAnimationBuilder(
      duration: dur,
      tween: ColorTween(begin: Colors.black, end: Colors.green),
      builder: (context, tween, child) {
        return TextButton(
          child: Text(
            "Sign Up",
            style: TextStyle(color: tween, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            signUpWithEmail(
                    email: _idController.text.trim(),
                    password: _passwordController.text)
                .then((value) {
              switch (value) {
                case 0:
                  Get.toNamed("/SignInPage");
                  break;
                case 1:
                  _passwordController.text = "";
                  _passwordCheckController.text = "";
                  Get.snackbar("Check your password", "Use stronger password",
                      duration: Duration(milliseconds: 5000),
                      isDismissible: true,
                      snackPosition: SnackPosition.TOP);
                  break;
                case 2:
                  _idController.text = "";
                  _passwordController.text = "";
                  _passwordCheckController.text = "";
                  Get.snackbar("Check your E-mail address",
                      "This E-mail is already exist.",
                      duration: Duration(milliseconds: 5000),
                      isDismissible: true,
                      snackPosition: SnackPosition.TOP);
                  break;
              }
            });
          },
        );
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return TweenAnimationBuilder(
      duration: dur,
      tween: ColorTween(begin: Colors.black, end: Colors.blue),
      builder: (context, tween, child) {
        return InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already a member?  ",
                style: TextStyle(color: tween),
              ),
              Text(
                "Sign In!",
                style: TextStyle(color: tween, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onTap: () {
            Get.offAndToNamed("/SignInPage");
          },
        );
      },
    );
  }
}
