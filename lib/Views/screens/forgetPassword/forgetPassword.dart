import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/Views/widgets/custom_textFieled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      Text(
                        'Forgot Password'.tr(),
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 30,
                          color: Color(0xff323232),
                          letterSpacing: -0.7235293006896972,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please enter your email below to recevie \nyour password reset instructions'.tr(),
                    style: TextStyle(
                      fontFamily: 'AvenirNextRoundedPro-Medium',
                      fontSize: 16,
                      color: const Color(0xff9b9b9b),
                    ),
                  ),
                  Form(
                    key: provider.passwordKey,
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
                              provider.forgetPassword();
                            },
                            child:  Center(
                              child: Text(
                                'Send Request'.tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
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
