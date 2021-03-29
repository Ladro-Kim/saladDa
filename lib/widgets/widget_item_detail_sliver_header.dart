import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salad_da/utils/images.dart';

class ItemDetailSliverHeaderWidget extends SliverPersistentHeaderDelegate {
  double minHeight;
  double maxHeight;
  Object tag;
  String photoUrl;

  ItemDetailSliverHeaderWidget(
      {this.minHeight = 0, this.maxHeight, this.tag, this.photoUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Hero(
      tag: tag,
      child: photoUrl == null
          ? Image.asset(dummy_image, fit: BoxFit.fitWidth)
          : Image.network(photoUrl),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
