import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/Advertisement/update_advertisement.dart';
import 'package:e_commerce_app/models/Ads.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvertisementDetailsWidget extends StatelessWidget {
  Advertisement advertisement;
  AdvertisementDetailsWidget(this.advertisement);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(children: [
        SizedBox(
            height: 175,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: advertisement.imageUrl,
              fit: BoxFit.cover,
            )),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Provider.of<FirestoreProvider>(context, listen: false)
                    .advertisementNameController
                    .text = advertisement.name.tr();
                AppRouter.NavigateToWidget(UpdateAdvertisement(advertisement));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [const Color(0xff667eea), const Color(0xff64b6ff)],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Text(
                  "Edit Advertisement".tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                Provider.of<FirestoreProvider>(context, listen: false)
                    .deleteAdvertisement(advertisement);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, 0.062),
                    end: Alignment(1.0, 0.123),
                    colors: [const Color(0xbfff5858), const Color(0xbffb5895)],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1f000000),
                      offset: Offset(0, 15),
                      blurRadius: 31,
                    ),
                  ],
                ),
                child: Text(
                  "Delete Advertisement".tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
