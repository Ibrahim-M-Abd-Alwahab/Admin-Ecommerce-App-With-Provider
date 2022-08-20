import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/category/update_category.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDetailsWidget extends StatelessWidget {
  Category category;
  CategoryDetailsWidget(this.category);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 10),
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
      child: Row(
        children: [
          SizedBox(
              height: 175,
              width: 150,
              child: CachedNetworkImage(
                imageUrl: category.imageUrl,
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name.tr(),
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 16,
                    color: const Color(0xff2a2a2a),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Provider.of<FirestoreProvider>(context, listen: false)
                      .categoryNameController
                      .text = category.name.tr();
                  // Provider.of<FirestoreProvider>(context, listen: false)
                  //     .imageSelected = File(category.imageUrl);
                  AppRouter.NavigateToWidget(UpdateCategory(category));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [
                        const Color(0xff667eea),
                        const Color(0xff64b6ff)
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Text(
                    "Edit Category".tr(),
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Provider.of<FirestoreProvider>(context, listen: false)
                      .deleteCategory(category);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.062),
                      end: Alignment(1.0, 0.123),
                      colors: [
                        const Color(0xbfff5858),
                        const Color(0xbffb5895)
                      ],
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
                    "Delete Category".tr(),
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
        ],
      ),
    );
  }
}
