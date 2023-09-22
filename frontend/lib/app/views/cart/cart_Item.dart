import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../route.dart';
import '../../models/cart_item.dart';

class CartItemCard extends StatefulWidget {
  final String productId;
  final CartItem cardItem;
  final bool selectedAll;
  const CartItemCard(
      {required this.productId,
      required this.cardItem,
      required this.selectedAll,
      super.key});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool selectedItem = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return _ShowConfirm();
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(widget.productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    print(widget.selectedAll);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Checkbox(
                value: selectedItem,
                activeColor: Colors.pink,
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                    selectedItem || widget.selectedAll
                        ? context
                            .read<CartManager>()
                            .addSelectedItem(widget.productId, widget.cardItem)
                        : context
                            .read<CartManager>()
                            .removerSelectItem(widget.productId);
                  });
                }),
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.cardItem.hinhsp),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(widget.cardItem.tensp),
                subtitle: Text(
                    'Thành tiền: ${widget.cardItem.giasp * widget.cardItem.soluongsp} VND'),
                trailing: Text('${widget.cardItem.soluongsp}x'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _ShowConfirm(){
    QuickAlert.show(
      context: context,
      title: 'Warning',
      text: 'Bạn có muốn xóa tài khoản này không?',
      type: QuickAlertType.confirm,
       );
  }
}
