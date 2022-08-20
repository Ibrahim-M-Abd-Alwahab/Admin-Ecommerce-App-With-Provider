import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/forgetPassword/forgetPassword.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/Views/widgets/custom_textFieled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xffC5CCD6),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icon.png"),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 80),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login".tr(),
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 30,
                          color: Color(0xff323232),
                          letterSpacing: -0.7235293006896972,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: provider.loginKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTextField(
                          prefixIcon: Icon(Icons.email),
                          title: "Email".tr(),
                          validator: provider.emailValidation,
                          controller: provider.emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.mail),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 12, left: 15),
                            child: FaIcon(
                              FontAwesomeIcons.lock,
                              size: 20,
                            ),
                          ),
                          title: "Enter Password".tr(),
                          validator: provider.passwordValidation,
                          keyboardType: TextInputType.visiblePassword,
                          controller: provider.passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          height: 49,
                          width: 327,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-0.947, 0.0),
                              end: Alignment(1.0, 0.0),
                              colors: [Color(0xff667eea), Color(0xff64b6ff)],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              provider.SignIn();
                            },
                            child: Center(
                              child: Text(
                                "Log in".tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Forgot password?".tr(),
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: const Color(0xff4f4f4f),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    AppRouter.NavigateToWidget(
                                        ForgetPasswordScreen());
                                  },
                                  child: Text(
                                    'Reset your password'.tr(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff667eea),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
