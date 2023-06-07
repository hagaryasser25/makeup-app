import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import '../models/makeup_model.dart';

class ApiService {
  String url = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";
  Future<List<MakeupModel>> getProducts() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      final memes = result.map(((e) => MakeupModel.fromJson(e))).toList();
      return memes;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  Future<List<MakeupModel>> getProductsbyCategory(String category) async {
    String url = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline&product_type=$category";
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      final memes = result.map(((e) => MakeupModel.fromJson(e))).toList();
      return memes;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
