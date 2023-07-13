import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/screen/product/details.dart';

import '../../data/product.dart';
import '../../widgets/loadingImage.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.borderRadius,
  });
  final BorderRadius borderRadius;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          )),
          borderRadius: borderRadius,
          child: SizedBox(
            width: 176,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 189,
                      width: 176,
                      child: loadingImageServer(
                        imageUrl: product.image,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: 28,
                        height: 28,
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    (product.previousPrice + product.discount).withPriceLabel,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .apply(decoration: TextDecoration.lineThrough),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                  child:
                      Text((product.price + product.discount).withPriceLabel),
                ),
              ],
            ),
          ),
        ));
  }
}
