import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:frontend/app/models/users.dart';
import 'package:frontend/app/views/cart/cart_manager.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import '../../../route.dart';
import '../../models/products.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/product_detail';
  final Product product;
  const ProductDetail(this.product, {super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var productQuantily = 1;
  @override
  Widget build(BuildContext context) {
    final userManager = context.read<UsersManager>();
    final List<String> list = <String>[];
    for (int i = 1; i <= userManager.soBan; i++) {
      list.add('Bàn số $i');
    }
    String dropdownValue = list.first;
    final a = widget.product.product_cmt as dynamic;
    final List<Comment> ah = [];
    a.forEach((element) {
      ah.add(Comment.fromJson(element));
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin Chi Tiết'),
      ),
      body:  Column(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 400,
                            alignment: Alignment.center,
                            child: Text('Hình'),
                          )
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.product_Ten,
                          style:
                              const TextStyle(color: Colors.pink, fontSize: 30),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Mã: ${widget.product.product_Ma}',
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Row(children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(Icons.star),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      child: Text(
                        '${widget.product.product_Price} VND',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    widget.product.product_MoTa,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(children: [
                const Text(
                  'Mã bàn: ',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style:
                      const TextStyle(color: Colors.deepPurple, fontSize: 20),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                      print(dropdownValue);
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ]),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: NumberPicker(
                      itemWidth: 50,
                      axis: Axis.horizontal,
                      value: productQuantily,
                      maxValue: 100,
                      minValue: 1,
                      step: 1,
                      onChanged: (value) {
                        setState(() {
                          productQuantily = value;
                          // print(productQuantily);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        context.read<TablesManager>().addCart(
                            widget.product, productQuantily, dropdownValue);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content:
                                const Text('Sản phẩm được thêm vào giỏ hàng'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  context
                                      .read<CartManager>()
                                      .removeSingleItem(widget.product.id!);
                                }),
                          ));
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pink),
                      child: const Text(
                        'Thêm món ăn',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: comment(ah),
          ),
        ],
      ),
    );
  }
}

Widget comment(List ah) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      children: [
        const Text(
          'Đánh giá sản phẩm',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          child: Row(children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Icon(Icons.star),
          ]),
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: ah.length,
              itemBuilder: (context, index) {
                return CommentGirdTitle(ah[index]);
              },
            ),
        ),
      ],
    ),
  );
}
