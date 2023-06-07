import 'package:flutter/widgets.dart';
import 'package:makeup_app/models/makeup_model.dart';
import 'package:makeup_app/services/makeup-service.dart';

class MakeupProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  List<MakeupModel> _makeup = [];
  List<MakeupModel> _makeupSearch = [];
  List _category = <MakeupModel>[];

  Future<void> getAllMemes() async {
    final response = await _service.getProducts();

    _makeup = response;
    _makeupSearch = response;
    notifyListeners();
  }

  Future<void> getByCategory(String category) async {
    isLoading = true;
    // final response = await _service.getProductsbyCategory(category);
    _category = (await _service.getProductsbyCategory(category));
    isLoading = false;
    notifyListeners();
  }

  List<MakeupModel> get makeup => _makeup;
  List get category => _category;

  search(char) {
   var makeup = _makeup;
   var makeupSearch = _makeupSearch;
    if (char.isEmpty) {
      makeup = makeupSearch;
      notifyListeners();
    } else {
      _makeup = [];
      for (MakeupModel model in makeupSearch) {
        if (model.name.contains(char)) {
          makeup.add(model);
        }
      }
      notifyListeners();
    }
  }
}
