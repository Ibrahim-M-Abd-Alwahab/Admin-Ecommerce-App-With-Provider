import 'dart:developer';
import 'dart:io';
import 'package:e_commerce_app/Router/router.dart';
import 'package:e_commerce_app/Views/screens/category/categories_screen.dart';
import 'package:e_commerce_app/data/fireStore_helper.dart';
import 'package:e_commerce_app/data/storage_helper.dart';
import 'package:e_commerce_app/models/Ads.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/offers.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreProvider extends ChangeNotifier {
  FirestoreProvider() {
    getAllAdvertisement();
    getAllOffers();
    getAllCategories();
  }

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productReviewsController = TextEditingController();
  TextEditingController productRateController = TextEditingController();
  TextEditingController offerNameController = TextEditingController();
  TextEditingController offerDiscountController = TextEditingController();
  TextEditingController advertisementNameController = TextEditingController();

  List<Category> categories = [];
  List<Product> products = [];
  List<Advertisement> advertisements = [];
  List<Offer> offers = [];
  selectImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageSelected = File(xFile!.path);
    notifyListeners();
  }

  /************************ Categories ********************* */
  File? imageSelected;

  addNewCategory() async {
    if (imageSelected != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(imageSelected!);
      Category category =
          Category(name: categoryNameController.text, imageUrl: imageUrl);
      Category newCategory =
          await FireStoreHelper.fireStoreHelperObject.addNewCategory(category);
      // getAllCategories() بدل مااعمل  categories ضفت التصنيف الجديد على آخر القائمة تاعت ال
      imageSelected = null;
      clearFields();
      categories.add(newCategory);

      notifyListeners();
    }
  }

  getAllCategories() async {
    categories = await FireStoreHelper.fireStoreHelperObject.getAllCategories();
    notifyListeners();
  }

  deleteCategory(Category category) async {
    await FireStoreHelper.fireStoreHelperObject.deleteCategory(category);
    // categories.removeWhere((element) => element.catId == category.catId);
    getAllCategories();
  }

  updateCategory(Category category) async {
    String? imageUrl;
    if (imageSelected != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(imageSelected!);
    }
    Category newCategory = Category(
        name: categoryNameController.text,
        // اذا المستخدم ما عمل تعديل على الصورة خدلي الصورة القديمة
        imageUrl: imageUrl ?? category.imageUrl);

    newCategory.catId = category.catId;
    await FireStoreHelper.fireStoreHelperObject.updateCategory(newCategory);
    imageSelected = null;
    getAllCategories();
    // int index = categories.indexOf(
    //     categories.where((element) => element.catId == category.catId).first);
    // categories[index] = newCategory;
  }

  /************************ Advertisement ************************ */

  addNewAdvertisement() async {
    if (imageSelected != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(imageSelected!);
      Advertisement advertisement = Advertisement(
          imageUrl: imageUrl, name: advertisementNameController.text);
      Advertisement newAdvertisement = await FireStoreHelper
          .fireStoreHelperObject
          .addNewAdvertisement(advertisement);
      imageSelected = null;
      advertisementNameController.text = " ";
      advertisements.add(newAdvertisement);
      notifyListeners();
    }
  }

  getAllAdvertisement() async {
    advertisements =
        await FireStoreHelper.fireStoreHelperObject.getAllAdvertisement();
    notifyListeners();
  }

  deleteAdvertisement(Advertisement advertisement) async {
    await FireStoreHelper.fireStoreHelperObject
        .deleteAdvertisement(advertisement);
    getAllAdvertisement();
  }

  updateAdvertisement(Advertisement advertisement) async {
    String? imageUrl;
    if (imageSelected != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(imageSelected!);
    }
    Advertisement newAdvertisement = Advertisement(
      imageUrl: imageUrl ?? advertisement.imageUrl,
      name: advertisementNameController.text,
    );
    newAdvertisement.id = advertisement.id;

    await FireStoreHelper.fireStoreHelperObject
        .updateAdvertisement(newAdvertisement);
    imageSelected = null;
    advertisementNameController.text = " ";
    getAllCategories();
  }

  /************************ Offer ************************ */

  addNewOffer() async {
    if (imageSelected != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(imageSelected!);
      Offer offer = Offer(
          name: offerNameController.text,
          discount: offerDiscountController.text,
          imageUrl: imageUrl);
      Offer newOffer =
          await FireStoreHelper.fireStoreHelperObject.addNewOffer(offer);
      imageSelected = null;
      offers.add(newOffer);
      notifyListeners();
    }
  }

  getAllOffers() async {
    offers = await FireStoreHelper.fireStoreHelperObject.getAllOffers();
    notifyListeners();
  }

  deleteOffers(Offer offer) async {
    await FireStoreHelper.fireStoreHelperObject.deleteOffers(offer);
    getAllOffers();
  }

  updateOffer(Offer offer) async {
    String? imageUrl;
    if (imageSelected != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(imageSelected!);
    }
    Offer newOffer = Offer(
        name: offerNameController.text,
        discount: offerDiscountController.text,
        imageUrl: imageUrl ?? offer.imageUrl);
    newOffer.id = offer.id;

    await FireStoreHelper.fireStoreHelperObject.updateOffer(newOffer);
    imageSelected = null;
    notifyListeners();
    getAllOffers();
  }
  /************************ Products ********************* */

  getAllProducts(String catId) async {
    products =
        await FireStoreHelper.fireStoreHelperObject.getAllProducts(catId);
    notifyListeners();
  }

  addNewProduct(String catId) async {
    // (imageSelected != null) ==> It means the user has already entered an image
    if (imageSelected != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(imageSelected!);

      Product product = Product(
        name: productNameController.text,
        description: productDescriptionController.text,
        image: imageUrl,
        price: num.parse(productPriceController.text),
        quantity: num.parse(productQuantityController.text),
        rate: num.parse(productRateController.text),
      );

      Product newProduct = await FireStoreHelper.fireStoreHelperObject
          .addNewProducts(product, catId);

      products.add(newProduct); // add newProduct to the list
      log(products.toString());
      imageSelected = null;
      clearFields();
      notifyListeners();
    }
  }

  updateProduct(Product product, String catId) async {
    String? imageUrl;
    if (imageSelected != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(imageSelected!);
    }
    Product newProduct = Product(
      name: productNameController.text,
      description: productDescriptionController.text,
      // image: imageUrl ?? product.image ==> لو ما تم ادخال صورة خدلي الصورة القديمة
      image: imageUrl ?? product.image,
      price: num.parse(productPriceController.text),
      quantity: int.parse(productQuantityController.text),
      rate: int.parse(productRateController.text),
    );
    newProduct.id = product.id;
    await FireStoreHelper.fireStoreHelperObject
        .updateProduct(newProduct, catId);

    // جلب الاندكس الخاص بالعنصر يلي بدي اعمل تحديث عليه واعدل عليه
    // int index = products
    //     .indexOf(products.where((element) => element.id == product.id).first);
    // products[index] = newProduct;
    getAllProducts(catId);
  }

  deleteProduct(Product product, String catId) async {
    await FireStoreHelper.fireStoreHelperObject.deleteProduct(product, catId);
    // products.removeWhere((element) => element.id == product.id);
    getAllProducts(catId);
  }

  clearFields() {
    imageSelected = null;
    categoryNameController.clear();
    productNameController..clear();
    productDescriptionController.clear();
    productImageController.clear();
    productPriceController.clear();
    productQuantityController.clear();
    productReviewsController.clear();
    productRateController.clear();
    offerNameController.clear();
    offerDiscountController.clear();
    advertisementNameController.clear();
  }
}
