import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/home/home_screen.dart';
import 'package:e_commerce_app/data/auth_helper.dart';
import 'package:e_commerce_app/data/fireStore_helper.dart';
import 'package:e_commerce_app/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  GlobalKey<FormState> passwordKey = GlobalKey();

  String? NameValidation(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Name is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  requiredValidation(String value) {
    if (!isEmail(value)) {
      return "Invalid email format";
    }
  }

  emailValidation(String value) {
    if (!isEmail(value)) {
      return "Invalid email format";
    }
  }

  offerValidation(String value) {
    if (!isEmail(value)) {
      return "Invalid email format";
    }
  }

  categoryValidation(String value) {
    if (!isEmail(value)) {
      return "Invalid email format";
    }
  }

  String? passwordValidation(String? value) {
    if ((value?.length ?? 0) < 6) {
      return 'Password must be more than 5 characters';
    } else {
      return null;
    }
  }

  String? mobileValidation(String? value) {
    String pattern = r'(^\+?[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Mobile phone number is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Mobile phone number must contain only digits";
    }
    return null;
  }

  SignIn() async {
    if (loginKey.currentState!.validate()) {
      UserCredential? credentials = await AuthHelper.authHelperObject
          .SignIn(emailController.text, passwordController.text);
      if (credentials != null) {
        AppRouter.NavigateWithReplacemtnToWidget(HomeScreen());
        emailController.text = '';
        passwordController.text = '';
      }
    }
  }

  // SignUp() async {
  //   if (signUpKey.currentState!.validate()) {
  //     UserCredential? credentials = await AuthHelper.authHelperObject
  //         .SignUp(emailController.text, passwordController.text);
  //     if (credentials != null) {
  //       AppRouter.NavigateWithReplacemtnToWidget(HomeScreen());
  //     }
  //   }
  // }

  checkUser() {
    AuthHelper.authHelperObject.checkUser();
  }

  signOut() {
    AuthHelper.authHelperObject.signOut();
  }

  forgetPassword() {
    if (passwordKey.currentState!.validate()) {
      AuthHelper.authHelperObject.forgetPassword("ibrabimmoh1@gmail.com");
    }
  }

  register() async {
    // you can sign up If you pass the register validation but If not an error message will be executed or appear
    if (signUpKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthHelper.authHelperObject
          .SignUp(emailController.text, passwordController.text);

      // Create New User
      AppUser appUser = AppUser(
        email: emailController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        id: userCredential!.user!.uid, // id of current user
      );

      // Add To Firestore
      FireStoreHelper.fireStoreHelperObject.addUserToFirestore(appUser);

      emailController.text = '';
      passwordController.text = '';
      phoneController.text = '';
      userNameController.text = '';
    }
  }
}
