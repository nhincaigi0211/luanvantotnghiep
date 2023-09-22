import 'package:flutter/material.dart';
import '../../../route.dart';
import 'package:provider/provider.dart';

import 'cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool selectAllProduct = false;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Column(children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Expanded(child: buildCartDetail(cart)),
        buildCartSummary(cart, context),
      ]),
    );
  }

  Widget buildCartDetail(CartManager cart) {
    // print(cart.selectedItemCount);
    return ListView(
        children: cart.productEntries
            .map((e) => CartItemCard(
                  productId: e.key,
                  cardItem: e.value,
                  selectedAll: selectAllProduct,
                ))
            .toList());
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    activeColor: Colors.pinkAccent,
                    value: selectAllProduct,
                    onChanged: (value) {
                      setState(() {
                        selectAllProduct = value!;
                        selectAllProduct
                            ? cart.switchToSelected()
                            : cart.clearSelectedItem(true);
                      });
                    }),
                const Text(
                  'Chọn tất cả sản phẩm',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Tổng tiền',
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    cart.selectedItemTotalAmount.toStringAsFixed(2),
                    // cart.totalAmount.toString(),
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge
                            ?.color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                // TextButton(
                //     onPressed: cart.selectedItemCount <= 0
                //         ? () {
                //             const Text("Bạn chưa lựa chọn hàng");
                //           }
                //         : () {
                //             context
                //                 .read<OrderManager>()
                //                 .addOrder(cart.products, cart.totalAmount);
                //             selectAllProduct
                //                 ? cart.clear()
                //                 : cart.clearSelectedItem(
                //                     false, cart.selectedProductList);
                //           },
                //     style: TextButton.styleFrom(
                //         textStyle:
                //             TextStyle(color: Theme.of(context).primaryColor)),
                //     child: const Text('Đặt hàng ngay'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
