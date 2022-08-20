import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/home/home_screen.dart';
import 'package:e_commerce_app/Views/widgets/custom_textFieled.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Offer").tr(),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: Color(0xff1572A1),
          foregroundColor: Colors.white,
        ),
        body: Consumer<FirestoreProvider>(builder: (context, provider, x) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                provider.imageSelected == null
                    ? InkWell(
                        onTap: () {
                          provider.selectImage();
                        },
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.grey,
                        ),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(provider.imageSelected!),
                      ),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomTextField(
                    title: "Offer Name".tr(),
                    validator:
                        Provider.of<AuthProvider>(context).offerValidation,
                    controller: provider.offerNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: CustomTextField(
                    title: "Discount value".tr(),
                    validator:
                        Provider.of<AuthProvider>(context).offerValidation,
                    controller: provider.offerDiscountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff1572A1),
                  ),
                  onPressed: () {
                    provider.getAllOffers();
                    provider.addNewOffer();
                    if (provider.imageSelected != null) {
                      AppRouter.NavigateToWidget(HomeScreen());
                    }
                  },
                  child: Text(
                    "Add New Offer".tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
