import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/products/all_product_screen.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProducts extends StatelessWidget {
  String catId;
  AddNewProducts(this.catId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Product").tr(),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: Color(0xff1572A1),
          foregroundColor: Colors.white,
        ),
        body: Consumer<FirestoreProvider>(builder: (context, provider, x) {
          return Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
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
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: provider.productNameController,
                      decoration: InputDecoration(
                        hintText: "Product Name".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: provider.productDescriptionController,
                      decoration: InputDecoration(
                        hintMaxLines: 5,
                        hintText: "Product Description".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: provider.productPriceController,
                      decoration: InputDecoration(
                        hintText: "Product Price".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: provider.productQuantityController,
                      decoration: InputDecoration(
                        hintText: "Product Quantity".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: provider.productRateController,
                      decoration: InputDecoration(
                        hintText: "Rating".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff1572A1),
                    ),
                    onPressed: () {
                      provider.getAllProducts(catId);
                      provider.addNewProduct(catId);
                      if (provider.imageSelected != null) {
                        AppRouter.NavigateToWidget(AllProductsScreen(catId));
                      }
                    },
                    child: Text(
                      "Add New Product".tr(),
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
            ),
          );
        }));
  }
}
