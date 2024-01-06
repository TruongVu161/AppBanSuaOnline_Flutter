
import 'package:AppBanSuaOnline_Flutter/model/shoe_type.dart';

class Product {
  String id = '';
  String name = '';
  String image = '';
  String description = '';
  double price = 0.0;
  String type = ShoeType.khac.toShortString();
  String uploadBy = '';
  String uploadDate = DateTime.now().toString();
  String editDate = DateTime.now().toString();

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.price,
      required this.type,
      required this.uploadBy,
      required this.uploadDate,
      required this.editDate});

  Product.empty() {
    id = '';
    name = '';
    image = '';
    description = '';
    price = 0.0;
    type = ShoeType.khac.toShortString();
    uploadBy = '';
    uploadDate = DateTime.now().toString();
    editDate = DateTime.now().toString();
  }

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    type = json['type'];
    uploadBy = json['uploadBy'];
    uploadDate = json['uploadDate'];
    editDate = json['editDate'];
  }

}
