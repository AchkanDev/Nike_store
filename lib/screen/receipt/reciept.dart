import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';

class ReceiptScreen extends StatelessWidget {
  final int pricePayable;

  const ReceiptScreen({super.key, required this.pricePayable});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("رسید پرداخت"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            // height: 150,
            margin: const EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.shadow)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "پرداخت با موفقیت انجام شد",
                    style: themeData.textTheme.titleLarge
                        ?.copyWith(color: themeData.colorScheme.primary),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "وضعیت سفارش",
                        style: themeData.textTheme.titleSmall,
                      ),
                      Text(
                        "پرداخت شده",
                        style: themeData.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 32,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "مبلغ",
                        style: themeData.textTheme.titleSmall,
                      ),
                      Text(
                        pricePayable.seprateByComma,
                        style: themeData.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("بازگشت به صفحه اصلی")),
        ],
      ),
    );
  }
}
