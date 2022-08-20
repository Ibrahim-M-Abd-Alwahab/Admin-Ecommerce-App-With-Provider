import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/category/categories_screen.dart';
import 'package:e_commerce_app/Views/screens/home/home_screen.dart';
import 'package:e_commerce_app/Views/widgets/custom_textFieled.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategory extends StatelessWidget {
  Category category;
  UpdateCategory(this.category);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Category").tr(),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,  
          ),
          elevation: 0,
          backgroundColor: Color(0xff1572A1),
          foregroundColor: Colors.white,
        ),
        body: Consumer<FirestoreProvider>(builder: (context, provider, x) {
          return Column(
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
                        backgroundImage: NetworkImage(category.imageUrl),
                      ),
                    )
                  : CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(provider.imageSelected!),
                    ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 050),
                child: CustomTextField(
                  title: "Product Name".tr(),
                  validator:
                      Provider.of<AuthProvider>(context).categoryValidation,
                  controller: provider.categoryNameController,
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
                  provider.updateCategory(category);
                  AppRouter.NavigateToWidget(CategoriesScreen());
                },
                child: Text(
                  "Edit Category".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        }));
  }
}
