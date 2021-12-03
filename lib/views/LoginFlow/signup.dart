import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pirai_code_challenge/animation/fade_animation.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'login.dart';

enum Field { fullname, Email, password, confirmpassword, phone }

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  Color enabled = const Color(0xFF827F8A);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  Field? selected;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    Provider.of<UserModel>(context).addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1A30),
      body: SingleChildScrollView(
        child: SizedBox(
          width: we,
          height: he,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: he * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: we * 0.04),
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.03,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 2),
                  ),
                ),
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  child: Text(
                    "Let us know about you!",
                    style:
                        GoogleFonts.heebo(color: Colors.grey, letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(height: he * 0.07),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.3,
                        height: he * 0.071,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: selected == Field.fullname
                              ? enabled
                              : backgroundColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name can\'t be empty!';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              selected = Field.fullname;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person_outlined,
                              color: selected == Field.fullname
                                  ? enabledtxt
                                  : deaible,
                            ),
                            hintText: 'FULL NAME',
                            hintStyle: TextStyle(
                              color: selected == Field.fullname
                                  ? enabledtxt
                                  : deaible,
                            ),
                          ),
                          style: TextStyle(
                              color: selected == Field.fullname
                                  ? enabledtxt
                                  : deaible,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.3,
                        height: he * 0.071,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: selected == Field.phone
                              ? enabled
                              : backgroundColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone can\'t be empty!';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              selected = Field.phone;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.phone_android_outlined,
                              color: selected == Field.phone
                                  ? enabledtxt
                                  : deaible,
                            ),
                            hintText: 'PHONE',
                            hintStyle: TextStyle(
                              color: selected == Field.phone
                                  ? enabledtxt
                                  : deaible,
                            ),
                          ),
                          style: TextStyle(
                              color: selected == Field.phone
                                  ? enabledtxt
                                  : deaible,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.3,
                        height: he * 0.071,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: selected == Field.Email
                              ? enabled
                              : backgroundColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email can\'t be empty!';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              selected = Field.Email;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: selected == Field.Email
                                  ? enabledtxt
                                  : deaible,
                            ),
                            hintText: 'EMAIL',
                            hintStyle: TextStyle(
                              color: selected == Field.Email
                                  ? enabledtxt
                                  : deaible,
                            ),
                          ),
                          style: TextStyle(
                              color: selected == Field.Email
                                  ? enabledtxt
                                  : deaible,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.3,
                        height: he * 0.071,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: selected == Field.password
                                ? enabled
                                : backgroundColor),
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t be empty!';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              selected = Field.password;
                            });
                          },
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                color: selected == Field.password
                                    ? enabledtxt
                                    : deaible,
                              ),
                              suffixIcon: IconButton(
                                icon: ispasswordev
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: selected == Field.password
                                            ? enabledtxt
                                            : deaible,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: selected == Field.password
                                            ? enabledtxt
                                            : deaible,
                                      ),
                                onPressed: () => setState(
                                    () => ispasswordev = !ispasswordev),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: selected == Field.password
                                      ? enabledtxt
                                      : deaible)),
                          obscureText: ispasswordev,
                          style: TextStyle(
                              color: selected == Field.password
                                  ? enabledtxt
                                  : deaible,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.3,
                        height: he * 0.071,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: selected == Field.confirmpassword
                                ? enabled
                                : backgroundColor),
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t be empty!';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              selected = Field.confirmpassword;
                            });
                          },
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                color: selected == Field.confirmpassword
                                    ? enabledtxt
                                    : deaible,
                              ),
                              suffixIcon: IconButton(
                                icon: ispasswordev
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: selected == Field.confirmpassword
                                            ? enabledtxt
                                            : deaible,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: selected == Field.confirmpassword
                                            ? enabledtxt
                                            : deaible,
                                      ),
                                onPressed: () => setState(
                                    () => ispasswordev = !ispasswordev),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: selected == Field.confirmpassword
                                      ? enabledtxt
                                      : deaible)),
                          obscureText: ispasswordev,
                          style: TextStyle(
                              color: selected == Field.confirmpassword
                                  ? enabledtxt
                                  : deaible,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ])),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          FirebaseAuthService.signupWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text);
                        } else {
                          confirmPasswordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Passwords don\'t match')),
                          );
                        }
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      style: GoogleFonts.heebo(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF0DF5E4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 80),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)))),
              ),
              SizedBox(height: he * 0.13),
              FadeAnimation(
                delay: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have a account?",
                        style: GoogleFonts.heebo(
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoginView();
                        }));
                      },
                      child: Text("Sign in",
                          style: GoogleFonts.heebo(
                            color: const Color(0xFF0DF5E4).withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
