import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/products/all_product_screen.dart';
import 'package:e_commerce_app/Views/widgets/custom_textFieled.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProduct extends StatelessWidget {
  Product product;
  String catId;
  UpdateProduct(this.product, this.catId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Product").tr(),
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
                            backgroundImage: NetworkImage(product.image),
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(provider.imageSelected!),
                        ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      title: "Product Name".tr(),
                      validator:
                          Provider.of<AuthProvider>(context).requiredValidation,
                      controller: provider.productNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      title: "Product description".tr(),
                      validator:
                          Provider.of<AuthProvider>(context).requiredValidation,
                      controller: provider.productDescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      title: "Product price".tr(),
                      validator:
                          Provider.of<AuthProvider>(context).requiredValidation,
                      controller: provider.productPriceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      title: "Product quantity".tr(),
                      validator:
                          Provider.of<AuthProvider>(context).requiredValidation,
                      controller: provider.productQuantityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      title: "Product rate".tr(),
                      validator:
                          Provider.of<AuthProvider>(context).requiredValidation,
                      controller: provider.productRateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff1572A1),
                    ),
                    onPressed: () {
                      provider.updateProduct(product, catId);
                      AppRouter.NavigateToWidget(AllProductsScreen(catId));
                    },
                    child: Text(
                      "New Product".tr(),
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
