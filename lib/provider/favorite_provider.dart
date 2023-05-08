import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/home.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Recipe> _favoriteList = [];
  List<Recipe> get favoriteList => _favoriteList;

  void toggleFavorite(Recipe fav) {
    final isExist = _favoriteList.contains(fav);
    if (isExist) {
      _favoriteList.remove(fav);
    } else {
      _favoriteList.add(fav);
    }
    notifyListeners();
  }

  bool isExist(Recipe fav) {
    final isExist = _favoriteList.contains(fav);
    return isExist;
  }

  void clearFavorite() {
    _favoriteList = [];
    notifyListeners();
  }

  static FavoriteProvider of(
      BuildContext context, {
        bool listen = true,
      }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}