import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/models/item.dart';
import 'package:salad_da/provs/provider_custom_user.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/screens/screen_item_detail.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Item> favoriteItems = <Item>[];

  @override
  Widget build(BuildContext context) {
    CustomUserProvider customUserProvider =
    Provider.of<CustomUserProvider>(context);
    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
    customUserProvider.customUser.favorites.map((e) async {
      favoriteItems.add(await firebaseProvider.getItemByName(e));
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView.builder(
          itemCount: favoriteItems.length,
          padding: EdgeInsets.all(2),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Container(
                height: 100,
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: buildItemImage(index),
                      ),
                      SizedBox(height: 20),
                      Center(child: Text(favoriteItems[index].name))
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ItemDetailScreen(
                            item: favoriteItems[index], tag: index)));
              },
            );
          }),
    );
  }

  Widget buildItemImage(int index) {
    return favoriteItems[index].imageUri == null
        ? Image.asset("assets/images/dummy_image.png")
        : Image.network(
      favoriteItems[index].imageUri,
      filterQuality: FilterQuality.low,
      loadingBuilder:
          (BuildContext context, Widget widget, ImageChunkEvent event) {
        if (event == null) return widget;
        return CircularProgressIndicator();
      },
    );
  }
}
