import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/product.dart';

import 'loadingImage.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const HorizontalProductList({
    super.key,
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              TextButton(onPressed: () {}, child: Text("مشاهده همه ")),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                  padding: const EdgeInsets.all(4),
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
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.title, maxLines: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            product.previousPrice.withPriceLabel,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4, left: 8, right: 8),
                          child: Text(product.price.withPriceLabel),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
