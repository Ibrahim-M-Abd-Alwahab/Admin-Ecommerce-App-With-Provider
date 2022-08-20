import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/products/add_product_screen.dart';
import 'package:e_commerce_app/Views/screens/products/widgets/product_details_widget.dart';
import 'package:e_commerce_app/providers/firestore_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatelessWidget {
  String catId;
  AllProductsScreen(this.catId);
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          title: Text("All Products").tr(),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: Color(0xff1572A1),
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            provider.products.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: provider.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: ProductWidget(
                                  provider.products[index], catId)),
                          SizedBox(height: 20)
                        ],
                      );
                    },
                  ),
            Positioned(
              bottom: 50,
              right: 15,
              child: FloatingActionButton(
                  backgroundColor: Color(0xff1572A1),
                  onPressed: () {
                    provider.clearFields();
                    AppRouter.NavigateToWidget(AddNewProducts(catId));
                  },
                  child: Icon(Icons.add)),
            )
          ],
        ),
      );
    });
  }
}
