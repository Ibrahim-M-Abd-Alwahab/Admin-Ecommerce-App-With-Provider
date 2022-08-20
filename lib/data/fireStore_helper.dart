import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Ads.dart';
import 'package:e_commerce_app/models/app_user.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/offers.dart';
import 'package:e_commerce_app/models/product.dart';

class FireStoreHelper {
  static FireStoreHelper fireStoreHelperObject = FireStoreHelper();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> categoryCollection =
      FirebaseFirestore.instance.collection("categories");
  CollectionReference<Map<String, dynamic>> adsCollection =
      FirebaseFirestore.instance.collection("Advertisement");
  CollectionReference<Map<String, dynamic>> offerCollection =
      FirebaseFirestore.instance.collection("Offers");

  addNewCategory(Category category) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await categoryCollection.add(category.toMap());
    category.catId =
        documentReference.id; // للتصنيف يلي بدي اضيفه ID هان انا حددت ال
    return category;
  }

  Future<List<Category>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await categoryCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    List<Category> categories = documents.map((e) {
      Category category = Category.fromMap(e.data());
      category.catId = e.id;
      // داخله ID الموجود عندي وخزنت ال map اضافة حقل جديد ل
      return category;
    }).toList();
    return categories;
  }

  deleteCategory(Category category) async {
    await categoryCollection.doc(category.catId).delete();
  }

  updateCategory(Category category) async {
    await categoryCollection.doc(category.catId).update(category.toMap());
  }

  /************************ Advertisement ************************ */
  addNewAdvertisement(Advertisement advertisement) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await adsCollection.add(advertisement.toMap());
    advertisement.id = documentReference.id;
    return advertisement;
  }

  Future<List<Advertisement>> getAllAdvertisement() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await adsCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    List<Advertisement> advertisements = documents.map((e) {
      Advertisement advertisement = Advertisement.fromMap(e.data());
      advertisement.id = e.id;
      log(advertisement.id);
      return advertisement;
    }).toList();
    return advertisements;
  }

  deleteAdvertisement(Advertisement advertisement) async {
    await adsCollection.doc(advertisement.id).delete();
  }

  updateAdvertisement(Advertisement advertisement) async {
    await adsCollection.doc(advertisement.id).update(advertisement.toMap());
  }

/************************ Offers ************************ */
  addNewOffer(Offer offer) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await offerCollection.add(offer.toMap());
    offer.id = documentReference.id;
    return offer;
  }

  Future<List<Offer>> getAllOffers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await offerCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    List<Offer> offers = documents.map((e) {
      Offer offer = Offer.fromMap(e.data());
      offer.id = e.id;
      log(offer.id);
      return offer;
    }).toList();
    return offers;
  }

  deleteOffers(Offer offer) async {
    await offerCollection.doc(offer.id).delete();
  }

  updateOffer(Offer offer) async {
    await offerCollection.doc(offer.id).update(offer.toMap());
  }

  /************************ Products ********************* */
  Future<Product> addNewProducts(Product product, String catId) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await FirebaseFirestore.instance
            .collection("categories")
            .doc(catId)
            .collection("products")
            .add(product.toMap());
    product.id = documentReference.id;
    log(product.toString());
    return product;
  }

  Future<List<Product>> getAllProducts(String catId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("categories")
        .doc(catId)
        .collection("products")
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        await querySnapshot.docs;

    List<Product> products = await documents.map((e) {
      Map<String, dynamic> data = e.data();
      data['id'] = e.id;
      Product product = Product.fromMap(data);
      return product;
    }).toList();

    return products;
  }

  updateProduct(Product product, String catId) async {
    await FirebaseFirestore.instance
        .collection("categories")
        .doc(catId)
        .collection("products")
        .doc(product.id)
        .update(product.toMap());
  }

  deleteProduct(Product product, String catId) async {
    await FirebaseFirestore.instance
        .collection("categories")
        .doc(catId)
        .collection("products")
        .doc(product.id)
        .delete();
  }

  /************************  Users  ********************** */

  addUserToFirestore(AppUser appUser) async {
    firestoreInstance.collection("users").doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestoreInstance.collection("users").doc(id).get();
    return AppUser.fromMap(documentSnapshot.data()!);
  }

  /*  
  /* add new document ==> (categories) */ 

  // final String categoryCollectionName = 'categories';
  // insertDummyDataInFirestore() async {
  //   firestoreInstance.collection(categoryCollectionName).add({
  //     "nameAr": "طعام",
  //     "nameEn": "Food",
  //     "imageUrl": "http://image.jpg",
  //   });
  // }

  /* add static or dummy data in specific document or new document */ 

  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');

  addUserToFirestoreStaticMap(
    String userName,
    String email,
    String id,
    String phone,
  ) async {
    userCollection.doc(id).set({
      "userName": userName,
      "email": email,
      "id": id,
      "phone": phone,
    });

    userCollection.add({
      "userName": userName,
      "email": email,
      "id": id,
      "phone": phone,
    });
  }

  Future<Map<String, dynamic>?> getUserFromfirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await userCollection.doc(id).get();
    Map<String, dynamic>? dataMap = documentSnapshot.data();
    return dataMap;
  }

  */
}
