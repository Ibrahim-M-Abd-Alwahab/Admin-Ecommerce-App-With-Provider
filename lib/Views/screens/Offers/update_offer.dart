import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/Advertisement/advertisement_screen.dart';
import 'package:e_commerce_app/Views/screens/Offers/offer_screen.dart';
import 'package:e_commerce_app/Views/widgets/custom_textFieled.dart';
import 'package:e_commerce_app/models/Ads.dart';
import 'package:e_commerce_app/models/offers.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateOffer extends StatelessWidget {
  Offer offer;
  UpdateOffer(this.offer);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Offer").tr(),
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
                          backgroundImage: NetworkImage(offer.imageUrl),
                        ),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(provider.imageSelected!),
                      ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                  child: CustomTextField(
                    title: "Offer name".tr(),
                    validator:
                        Provider.of<AuthProvider>(context).offerValidation,
                    controller: provider.offerNameController,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(40),
                        child: Icon(Icons.mail),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: CustomTextField(
                    title: "Offer description".tr(),
                    validator:
                        Provider.of<AuthProvider>(context).offerValidation,
                    controller: provider.offerDiscountController,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(40),
                        child: Icon(Icons.mail),
                      ),
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
                    provider.updateOffer(offer);
                    AppRouter.NavigateToWidget(OfferScreen());
                  },
                  child: Text(
                    "Edit Offer".tr(),
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
