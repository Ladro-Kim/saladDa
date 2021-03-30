import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/models/item.dart';
import 'package:salad_da/provs/provider_bottom_index.dart';
import 'package:salad_da/provs/provider_cart.dart';
import 'package:salad_da/provs/provider_custom_user.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/widgets/widget_item_detail_sliver_header.dart';

class ItemDetailScreen extends StatefulWidget {
  Item item;
  int tag;

  ItemDetailScreen({@required this.tag, @required this.item});

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              buildSliverAppBar(context),
              buildSliverHeader(),
              buildItemName(),
              buildItemInfo(),
            ],
          )),
    );
  }



  Widget buildItemName() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      title: Text(
        "${widget.item.name}",
        style: TextStyle(color: Colors.black87),
      ),
      pinned: true,
      leading: TextButton(
        onPressed: () {},
        child: Text(""),
      ),
      elevation: 0,
    );
  }


  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      actions: [
        TextButton.icon(
          icon: Icon(
            Icons.add_shopping_cart_rounded,
            color: Colors.white,
          ),
          label: Text(
            "Add to Cart",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget buildSliverHeader() {
    return SliverPersistentHeader(
      delegate: ItemDetailSliverHeaderWidget(
        minHeight: 0,
        maxHeight: 300,
        tag: widget.tag,
        photoUrl: widget.item.imageUri,
        // child:
      ),
    );
  }

  Widget buildItemInfo() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Text(
            "${widget.item.information}",
            textAlign: TextAlign.center,
          ),
          Divider(),
          infoTable(
              title: "영양성분",
              content: "탄수화물 : 28.1g"
                  "\n단백질 : 2.2g"
                  "\n지방 : 13.4g"
                  "\n당류 : 21.5g"
                  "\n나트륨 : 105.47mg"
                  "\n콜레스테롤 : 6.78mg"
                  "\n포화지방산 : 2g"
                  "\n트랜스지방 : 0.1g"),
          Divider(),
          infoTable(
              title: "Calories",
              content:
              "${NumberFormat("###,###,###,###").format(widget.item.calorie).replaceAll(' ', '')}"),
          Divider(),
          SizedBox(height: 40),
          infoTable(
              title: "Price",
              content:
              "${NumberFormat("###,###,###,###").format(widget.item.price).replaceAll(' ', '')}",
              divider: false),
          SizedBox(height: 40),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildButtons() {
    CustomUserProvider customUserProvider = Provider.of<CustomUserProvider>(context, listen: false);
    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context, listen: false);
    return Consumer<BottomIndexProvider>(builder: (context, provider, child) {
          return Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.green,
                    child: Text(
                      "Add to Cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    if (!customUserProvider.customUser.favorites.contains(widget.item.name)) {
                      customUserProvider.customUser.favorites.add(widget.item.name);
                      customUserProvider.setCustomUser();
                      customUserProvider.getCustomUser();
                      Provider.of<CartProvider>(context, listen: false).getFavoriteItems(customUserProvider, firebaseProvider);
                      // FirebaseFirestore.instance
                      // .doc("Item")
                      // .collection("Items")
                      // .add();
                      Navigator.pop(context);
                    } else {
                      Get.snackbar("Same item.", "Same item is already in your cart");
                    }
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.blueAccent,
                    child: Text(
                      "Buy",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    provider.changeIndex(2);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget infoTable(
      {String title = "null", String content = "null", bool divider = true}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
          divider ? VerticalDivider() : VerticalDivider(color: Colors.white),
          Expanded(
            flex: 3,
            child: Text(
              content,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
