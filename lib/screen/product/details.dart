import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/screen/product/comment/comment_list.dart';
import 'package:nike_store/widgets/loadingImage.dart';
import 'package:nike_store/widgets/theme.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                "افزودن به سبد خرید",
                style: Theme.of(context).textTheme.bodyText2,
              )),
        ),
        body: CustomScrollView(
          physics: defaultPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: loadingImageServer(imageUrl: product.image),
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              actions: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.heart),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            product.previousPrice.withPriceLabel,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough),
                          ),
                          Text(product.price.withPriceLabel),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    " این کتونی بسیار خوب میباشد و دارای جنس ابریشم است و میتواند در اعماق آب از آن استفاده شود بدون اسیب جدی به آن وارد شود پیشنهاد ویژه ما استفاده این کفش با ضمانت معتبر و در صورت خرایی تعویض کفش صورت میگیرد  ",
                    maxLines: 2,
                    style: TextStyle(height: 1.2),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("نظرات کاربران",
                          style: Theme.of(context).textTheme.subtitle2),
                      TextButton(
                          onPressed: () {}, child: const Text("مشاهده همه")),
                    ],
                  ),
                ]),
              ),
            ),
            CommentList(productId: product.id)
          ],
        ),
      ),
    );
  }
}
