import 'package:flutter/material.dart';
import 'package:nike_store/screen/cart/cart_price_info.dart';
import 'package:nike_store/screen/receipt/reciept.dart';

class ShippingCart extends StatelessWidget {
  final int pricePayable;
  final int priceTotal;
  final int shippingCost;

  const ShippingCart(
      {super.key,
      required this.pricePayable,
      required this.priceTotal,
      required this.shippingCost});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("شیوه پرداخت"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  label: const Text("نام و نام خانوادگی"),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                  label: const Text("کدپستی"),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                  label: const Text("شماره تماس"),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "تهران - کوچه یاس - پلاک 20",
                  label: const Text("آدرس تحویل گیرنده"),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1)))),
            ),
            CartPriceInfo(
                pricePayable: pricePayable,
                priceTotal: priceTotal,
                shippingCost: shippingCost),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ReceiptScreen(pricePayable: pricePayable),
                      ));
                    },
                    child: const Text("پرداخت اینترنتی")),
                const SizedBox(
                  width: 12,
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ReceiptScreen(pricePayable: pricePayable),
                      ));
                    },
                    child: const Text("پرداخت در محل")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
