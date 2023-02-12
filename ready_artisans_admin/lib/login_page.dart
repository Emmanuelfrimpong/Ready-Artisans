import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans_admin/Components/custom_button.dart';
import 'Components/text_inputs.dart';
import 'Constants/strings.dart';
import 'app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();
  String? _loginEmail;
  String? _loginPassword;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Center(
                child: Card(
                    elevation: 10,
                    child: SizedBox(
                        width: size.width * .6,
                        child: Form(
                            key: _loginFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            color: Colors.white,
                                            height: 400,
                                            padding: const EdgeInsets.all(10),
                                            child: Column(children: [
                                              Image.asset(
                                                'assets/images/logo_large_t.png',
                                                width: 350,
                                                height: 350,
                                              )
                                            ]),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              color: primaryColor,
                                              height: 400,
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ADMIN LOGIN',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    const Divider(
                                                      thickness: 5,
                                                      color: Colors.white54,
                                                    ),
                                                    const SizedBox(
                                                      height: 40,
                                                    ),
                                                    CustomTextFields(
                                                        label: 'Admin Email',
                                                        prefixIcon:
                                                            Icons.person,
                                                        color:
                                                            Colors.transparent,
                                                        onSaved: (p0) {
                                                          setState(() {
                                                            _loginEmail = p0;
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty ||
                                                              !emailRegEx
                                                                  .hasMatch(
                                                                      value)) {
                                                            return 'Please enter a valid email';
                                                          }
                                                          return null;
                                                        }),
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    CustomTextFields(
                                                        label: 'Admin Password',
                                                        prefixIcon: Icons.lock,
                                                        obscureText:
                                                            _obscureText,
                                                        suffixIcon: IconButton(
                                                            icon: Icon(
                                                                _obscureText
                                                                    ? Icons
                                                                        .visibility
                                                                    : Icons
                                                                        .visibility_off,
                                                                color: Colors
                                                                    .white54),
                                                            onPressed: () {
                                                              setState(() {
                                                                _obscureText =
                                                                    !_obscureText;
                                                              });
                                                            }),
                                                        color:
                                                            Colors.transparent,
                                                        onSaved: (p0) {
                                                          setState(() {
                                                            _loginPassword = p0;
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty ||
                                                              value.length <
                                                                  6) {
                                                            return 'Admin Password must be at least 6 characters long';
                                                          }
                                                          return null;
                                                        }),
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    CustomButton(
                                                        onPressed: signin,
                                                        text: 'Sign In')
                                                  ])),
                                        )
                                      ]),
                                ],
                              ),
                            ))))),
          );
        } else {
          return Center();
        }
      }),
    );
  }

  void signin() {}
}
