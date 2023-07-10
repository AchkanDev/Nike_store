import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/cart_item.dart';
import 'package:nike_store/main.dart';

import '../../widgets/loadingImage.dart';
import 'bloc/cart_bloc.dart';

class CartItem extends StatelessWidget {
  final CartSuccess state;
  const CartItem({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: defaultPhysics,
      itemCount: state.cartResponse.cartItems.length,
      itemBuilder: (context, index) {
        final data = state.cartResponse.cartItems[index];
        return itemCardForBug(data: data);
      },
    );
  }
}

class itemCardForBug extends StatelessWidget {
  const itemCardForBug({
    super.key,
    required this.data,
  });

  final CartItemEntity data;

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Container(
      margin: const EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: Theme.of(context).colorScheme.shadow),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: loadingImageServer(
                    imageUrl: data.productEntity.image,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.productEntity.title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "تعداد",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.apply(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.plus_rectangle)),
                      Text(
                        data.count.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.minus_rectangle)),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      data.productEntity.previousPrice.withPriceLabel,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ).copyWith(fontSize: 12),
                    ),
                    Text(
                      (data.productEntity.price - data.productEntity.discount)
                          .withPriceLabel,
                    ),
                  ],
                ),
              )
            ],
          ),
          TextButton(onPressed: () {}, child: Text("حذف از سبد خرید"))
        ],
      ),
    );
  }
}
