import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/login/loginScreen.dart';
import 'package:e_commerce_app/Views/screens/register/SignUpScreen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                  color: Color(0xff707070),
                ),
                children: [
                  TextSpan(
                    text: "Welcome to ".tr(),
                  ),
                  TextSpan(
                    text: 'Amazing Ecommerce'.tr(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Explore Us'.tr(),
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                color: Color(0xff707070),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 175),
              child: const Image(image: AssetImage("assets/images/Image.png")),
            ),
            Container(
              margin: const EdgeInsets.only(top: 110),
              height: 49,
              width: 245,
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
                  AppRouter.NavigateToWidget(LoginScreen());
                },
                child: Center(
                  child: Text(
                    'Log in'.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 49,
                width: 245,
                child: InkWell(
                  onTap: () {
                    AppRouter.NavigateToWidget(SignUpScreen());
                  },
                  child: Center(
                    child: Text(
                      "Signup".tr(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff454242),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
