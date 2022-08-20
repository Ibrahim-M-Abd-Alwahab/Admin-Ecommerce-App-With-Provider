import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/products/update_product_screen.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  String catId;
  ProductWidget(this.product, this.catId);
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
              width: 200,
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.tr(),
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
                        .productNameController
                        .text = product.name.tr();
                    Provider.of<FirestoreProvider>(context, listen: false)
                        .productDescriptionController
                        .text = product.description.tr();
                    Provider.of<FirestoreProvider>(context, listen: false)
                        .productPriceController
                        .text = product.price.toString().tr();
                    Provider.of<FirestoreProvider>(context, listen: false)
                        .productQuantityController
                        .text = product.quantity.toString().tr();
                    Provider.of<FirestoreProvider>(context, listen: false)
                        .productRateController
                        .text = product.rate.toString().tr();

                    AppRouter.NavigateToWidget(UpdateProduct(product, catId));
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
                      "Edit Product".tr(),
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
                        .deleteProduct(product, catId);
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
                      "Delete Product".tr(),
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
          ),
        ],
      ),
    );
  }
}
