import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/models/item.dart';
import 'package:salad_da/provs/provider_background_color.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/screens/screen_item_detail.dart';
import 'package:salad_da/utils/images.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Color backgroundColor;
  int gridCount = 2;

  AnimationController animationController;
  Animation transAnimation;
  Widget dogWidget;

  void onAnimationStatusEvent() {
    animationController.addStatusListener((status) {
      if (transAnimation.value == Offset(110.0, 0.0)) {
        dogWidget = Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.1)
            ..rotateY(pi),
          alignment: FractionalOffset.center,
          child: Image.asset("assets/images/dog.gif"),
        );
        animationController.reverse();
      } else if (transAnimation.value == Offset(0.0, 0.0)) {
        dogWidget = Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.1)
            ..rotateY(0),
          alignment: FractionalOffset.center,
          child: Image.asset("assets/images/dog.gif"),
        );
        animationController.forward();
      }
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
      reverseDuration: Duration(milliseconds: 3000),
    );
    transAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(110, 0))
        .animate(animationController);
    animationController.forward();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    onAnimationStatusEvent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = Provider.of<BackgroundColorProvider>(context).color;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildAppBar() {
    Radius rad = Radius.circular(12);
    return PreferredSize(
      preferredSize: Size.fromHeight(59),
      child: Stack(
        children: [
          Container(
            color: backgroundColor,
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.center,
              height: 45,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: rad),
                color: Colors.black,
              ),
              child: Consumer<BackgroundColorProvider>(
                  builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.graphic_eq,
                        size: 24,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () async {
                        await showColorPickerModal(provider);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.grid_on_rounded,
                        size: 24,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () async {
                        await showGridCountPickerModal(provider);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart_rounded,
                        size: 24,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () {},
                    ),
                  ],
                );
              }),
            ),
          ),
          AnimatedBuilder(
              animation: animationController,
              builder: (context, widget) {
                return Transform.translate(
                  offset: transAnimation.value,
                  child: dogWidget,
                );
              }),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Consumer<FirebaseProvider>(builder: (context, provider, child) {
      return CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          CarouselItems(provider.items),
          GridItems(provider.items),
        ],
      );
    });
  }

  Widget CarouselItems(List<Item> items) {
    List<Item> topItems = <Item>[];
    if (items == null) {
      return SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()));
    }
    items.forEach((element) {
      if (element.isTopSeller == true) topItems.add(element);
    });
    if (topItems.length <= 1) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.greenAccent,
        child: CarouselSlider.builder(
            itemCount: topItems.length,
            itemBuilder: (context, index, value) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(topItems[index].imageUri),
              );
            },
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlayInterval: Duration(milliseconds: 3500),
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              autoPlay: true,
              aspectRatio: 1.6,
              autoPlayCurve: Curves.fastOutSlowIn,
            )),
      ),
    );
  }

  Widget GridItems(List<Item> items) {
    return SliverPadding(
      padding: const EdgeInsets.all(2.0),
      sliver: items != null
          ? SliverGrid.count(
              childAspectRatio: 0.9,
              crossAxisCount: gridCount,
              children: List.generate(
                items.length,
                (index) => InkWell(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container(), flex: 2),
                            Expanded(
                                child: Hero(
                                  tag: index,
                                  child: items[index].imageUri == null
                                      ? Image.asset(
                                          dummy_image,
                                          fit: BoxFit.fitWidth,
                                        )
                                      :
                                  // CachedNetworkImage(
                                  //         placeholder: (context, url) =>
                                  //             CircularProgressIndicator(),
                                  //         imageUrl: items[index].imageUri,
                                  //       ),
                                  Image.network(
                                          items[index].imageUri,
                                          filterQuality: FilterQuality.low,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child:
                                                  SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
                                            );
                                          },
                                        ),
                                ),
                                flex: 20),
                            Expanded(child: Container(), flex: 1),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text("${items[index].name}", overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                    elevation: 3,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ItemDetailScreen(
                                  tag: index,
                                  item: items[index],
                                )));
                    // Get.toNamed("/ItemDetailScreen");
                  },
                ),
              ).toList(),
            )
          : SliverToBoxAdapter(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> showColorPickerModal(BackgroundColorProvider provider) async {
    backgroundColor = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text("Background Color"),
          message: Text("Change your home screen color!"),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                "White",
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () {
                provider.ChangeColor(0);
                Navigator.pop(context, Colors.white);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                "Blue",
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              onPressed: () {
                provider.ChangeColor(1);
                Navigator.pop(context, Colors.lightBlueAccent);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                "Green",
                style: TextStyle(color: Colors.greenAccent),
              ),
              onPressed: () {
                provider.ChangeColor(2);
                Navigator.pop(context, Colors.greenAccent);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                "Orange",
                style: TextStyle(color: Colors.orangeAccent),
              ),
              onPressed: () {
                provider.ChangeColor(3);
                Navigator.pop(context, Colors.orangeAccent);
              },
            ),
          ],
          cancelButton: Center(
            child: TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              onPressed: () {
                Navigator.pop(context, backgroundColor);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> showGridCountPickerModal(
      BackgroundColorProvider provider) async {
    gridCount = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text("Picture grid count"),
            message: Text("Set item grid count"),
            actions: [
              CupertinoActionSheetAction(
                child: Text("1"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context, 1);
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text("2"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context, 2);
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text("3"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context, 3);
                  });
                },
              ),
            ],
          );
        });
  }
}

//
// SliverGrid(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// childAspectRatio: 1,
// crossAxisSpacing: 5,
// mainAxisSpacing: 5,
// crossAxisCount: gridCount,
// ),
// delegate:
// SliverChildBuilderDelegate((BuildContext context, int index) {
// return Card(
// child: Text("$index"),
// );
// }),
// ),
