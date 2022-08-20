import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/category/categories_screen.dart';
import 'package:e_commerce_app/Views/screens/home/home_screen.dart';
import 'package:e_commerce_app/Views/screens/products/add_product_screen.dart';
import 'package:e_commerce_app/Views/screens/splach/welcome_screen.dart';
import 'package:e_commerce_app/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelperObject = AuthHelper._();
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  Future<UserCredential?> SignIn(String email, String password) async {
    try {
      final credential = await firebaseAuthInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return credential; // information of user
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.ShowDialogFunction("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        CustomDialog.ShowDialogFunction(
            "Wrong password provided for that user.");
      }
    }
  }

  Future<UserCredential?> SignUp(String email, String password) async {
    // CustomDialog.ShowDialogFunction(
    //     "Thanks your account has been successfully created.");
    try {
      final credential = await firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.ShowDialogFunction("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.ShowDialogFunction(
            "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  checkUser() {
    // Returns the current User if they are currently signed-in or not.
    User? user = firebaseAuthInstance.currentUser;
    if (user == null) {
      AppRouter.NavigateWithReplacemtnToWidget(WelcomeScreen());
    } else {
      AppRouter.NavigateWithReplacemtnToWidget(HomeScreen());
    }
  }

  signOut() async {
    await firebaseAuthInstance.signOut();
    AppRouter.NavigateWithReplacemtnToWidget(WelcomeScreen());
  }

  forgetPassword(String email) async {
    try {
      await firebaseAuthInstance.sendPasswordResetEmail(email: email);
    } on Exception catch (e) {
      CustomDialog.ShowDialogFunction("Check your email to reset password");
    }
  }
}
