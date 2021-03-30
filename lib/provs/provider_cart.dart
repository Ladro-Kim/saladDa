import 'package:flutter/material.dart';
import 'package:salad_da/models/item.dart';
import 'package:salad_da/provs/provider_custom_user.dart';
import 'package:salad_da/provs/provider_firebase.dart';

class CartProvider extends ChangeNotifier {
  List<Item> favoriteItems;

  List<Item> getFavoriteItems(CustomUserProvider customUserProvider, FirebaseProvider firebaseProvider) {
    favoriteItems = <Item>[];
    customUserProvider.customUser.favorites.map((e) async {
      Item tempItem = await firebaseProvider.getItemByName(e);
      favoriteItems.add(tempItem);
    }).toList();
    return favoriteItems;
  }

  // getFavoriteItems(CustomUserProvider customUserProvider, FirebaseProvider firebaseProvider) async {
  //   favoriteItems = <Item>[];
  //
  //   customUserProvider.customUser.favorites.map((e) async {
  //     Item tempItem = await firebaseProvider.getItemByName(e);
  //     favoriteItems.add(tempItem);
  //   }).toList();
  // }

}
