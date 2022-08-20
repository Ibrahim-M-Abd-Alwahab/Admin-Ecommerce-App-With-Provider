import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/Advertisement/advertisement_screen.dart';
import 'package:e_commerce_app/models/Ads.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateAdvertisement extends StatelessWidget {
  Advertisement advertisement;
  UpdateAdvertisement(this.advertisement);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Advertisement").tr(),
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
                          backgroundImage: NetworkImage(advertisement.imageUrl),
                        ),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(provider.imageSelected!),
                      ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: TextField(
                    controller: provider.advertisementNameController,
                    decoration: InputDecoration(
                      hintText: "Name",
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
                    provider.getAllAdvertisement();
                    provider.updateAdvertisement(advertisement);
                    AppRouter.NavigateToWidget(AdvertisementScreen());
                  },
                  child: Text(
                    "Edit Advertisement".tr(),
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
